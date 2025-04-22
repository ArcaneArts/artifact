import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/artifact.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

class ArtifactBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const <String, List<String>>{
    r'$lib$': <String>['gen/artifacts.gen.dart'],
  };

  static Glob _dartFilesInLib = Glob('lib/**.dart');
  static final TypeChecker _artifactChecker = TypeChecker.fromRuntime(Artifact);

  static final Map<String, List<String>> _artifactSubclasses =
      <String, List<String>>{};

  static void _linkSubclass(ClassElement sub, ClassElement sup) {
    List<String> list = _artifactSubclasses.putIfAbsent(
      sup.name,
      () => <String>[],
    );
    if (!list.contains(sub.name)) list.add(sub.name);
  }

  bool _isArtifactInterface(InterfaceType type) => ArtifactBuilder
      ._artifactChecker
      .hasAnnotationOf(type.element, throwOnUnresolved: false);

  @override
  Future<void> build(BuildStep step) async {
    assert(step.inputId.path == r'$lib$');
    List<ClassElement> artifacts = <ClassElement>[];

    await for (AssetId asset in step.findAssets(_dartFilesInLib)) {
      if (!await step.resolver.isLibrary(asset)) continue;
      LibraryElement lib = await step.resolver.libraryFor(asset);

      for (Element e in lib.topLevelElements) {
        if (e is! ClassElement) continue;
        if (!_artifactChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
          continue;
        }

        artifacts.add(e);

        // walk super‑chain, link every annotated ancestor
        InterfaceType? supType = e.supertype;
        while (supType != null) {
          ClassElement sup = supType.element as ClassElement;
          if (_artifactChecker.hasAnnotationOf(sup, throwOnUnresolved: false)) {
            _linkSubclass(e, sup);
          }
          supType = supType.element.supertype;
        }
      }
    }

    Set<Uri> imports = <Uri>{};
    List<StringBuffer> classBuffers = <StringBuffer>[];
    List<Future<void>> work = <Future<void>>[];

    for (ClassElement art in artifacts) {
      imports.add(art.source.uri);
      work.add(
        generate(art).then((v) {
          imports.addAll(v.$1);
          classBuffers.add(v.$2);
        }),
      );
    }

    await Future.wait(work);

    StringBuffer outBuf =
        StringBuffer()
          ..writeln('// GENERATED – do not modify by hand\n')
          ..writeln(
            imports.map((i) => 'import "$i";').toSet().toList().join('\n'),
          )
          ..writeln();

    for (StringBuffer cb in classBuffers) {
      outBuf.writeln(cb);
    }

    AssetId out = AssetId(step.inputId.package, 'lib/gen/artifacts.gen.dart');
    await step.writeAsString(out, outBuf.toString());
  }

  Uri getImport(InterfaceType type, LibraryElement targetLib) {
    LibraryElement definingLib = type.element.library!;
    Uri importUri = definingLib.source.uri; // eg. package:resilient_models/…
    if (definingLib == targetLib) return Uri(); // empty = skip
    return importUri;
  }

  Future<(List<Uri>, StringBuffer)> generate(ClassElement clazz) async {
    StringBuffer buffer = StringBuffer();
    List<(List<Uri>, StringBuffer)> jobs = await Future.wait([
      generateToMap(clazz),
      generateFromMap(clazz),
      generateCopyWith(clazz),
    ]);
    StringBuffer nl = StringBuffer()..writeln("\n");
    buffer.writeln("extension \$${clazz.name} on ${clazz.name} {");

    for (StringBuffer i in jobs.expand((i) => [nl, i.$2]).skip(1)) {
      buffer.writeln(i);
    }

    buffer.writeln("}");

    return (<Uri>[...jobs.expand((i) => i.$1)], buffer);
  }

  Future<(List<Uri>, StringBuffer)> generateToMap(ClassElement clazz) async {
    ConstructorElement? ctor;
    for (ConstructorElement c in clazz.constructors) {
      if (c.name.isEmpty) {
        ctor = c;
        break;
      }
    }
    if (ctor == null) return (<Uri>[], StringBuffer());

    List<ParameterElement> params = <ParameterElement>[];
    for (ParameterElement p in ctor.parameters) {
      bool matchesField = clazz.getField(p.name) != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }

    // always generate the map – even if only the subclass keys go in it
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;

    buf.writeln('  Map<String, dynamic> toMap() => <String, dynamic>{');

    // 1️⃣  polymorphism tag(s)
    InterfaceType? supType = clazz.supertype;
    while (supType != null) {
      ClassElement sup = supType.element as ClassElement;
      if (_artifactChecker.hasAnnotationOf(sup, throwOnUnresolved: false)) {
        buf.writeln(
          "    '_subclass_${sup.name}': '${clazz.name}',",
        ); // e.g. _subclass_Animal
      }
      supType = supType.element.supertype;
    }

    // 2️⃣  regular fields
    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;

      ({String code, List<Uri> imports}) conv = _convert(
        name,
        type,
        targetLib,
        _ConvMode.toMap,
      );

      buf.writeln("    '$name': ${conv.code},");
      importUris.addAll(conv.imports);
    }

    buf.writeln('  };');
    return (importUris, buf);
  }

  Future<(List<Uri>, StringBuffer)> generateFromMap(ClassElement clazz) async {
    ConstructorElement? ctor;
    for (ConstructorElement c in clazz.constructors) {
      if (c.name.isEmpty) {
        ctor = c;
        break;
      }
    }
    if (ctor == null) return (<Uri>[], StringBuffer());

    List<ParameterElement> params = <ParameterElement>[];
    for (ParameterElement p in ctor.parameters) {
      bool matchesField = clazz.getField(p.name) != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }

    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;

    buf.writeln('  static ${clazz.name} fromMap(Map<String, dynamic> map) {');

    // ── 1️⃣  check polymorphism tag ───────────────────────────────────────────
    List<String>? subs = _artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      buf.writeln("    if (map.containsKey('_subclass_${clazz.name}')) {");
      buf.writeln(
        "      String sub = map['_subclass_${clazz.name}'] as String;",
      );
      buf.writeln('      switch (sub) {');
      for (String s in subs) {
        buf.writeln("        case '$s':");
        buf.writeln('          return \$$s.fromMap(map);');
      }
      buf.writeln('      }');
      buf.writeln('    }');
    }

    buf.writeln('    return ${clazz.name}(');

    List<String> positionalArgs = <String>[];
    List<String> namedArgs = <String>[];

    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;
      bool isNullable = type.nullabilitySuffix == NullabilitySuffix.question;
      bool isRequired =
          param.isRequiredNamed ||
          param.isRequiredPositional ||
          (!isNullable && param.defaultValueCode == null);
      String rawExpr = "map['$name']";

      ({String code, List<Uri> imports}) conv = _convert(
        rawExpr,
        type,
        targetLib,
        _ConvMode.fromMap,
      );
      importUris.addAll(conv.imports);

      String valueExpr;
      if (isRequired) {
        valueExpr =
            "map.containsKey('$name') ? ${conv.code} : (throw ArgumentError('Missing required ${clazz.name}.\"$name\" in map \$map.'))";
      } else {
        String defaultCode = param.defaultValueCode ?? 'null';
        valueExpr = "map.containsKey('$name') ? ${conv.code} : $defaultCode";
      }

      if (param.isNamed) {
        namedArgs.add('$name: $valueExpr');
      } else {
        positionalArgs.add(valueExpr);
      }
    }

    for (String a in positionalArgs) {
      buf.writeln('      $a,');
    }
    for (String a in namedArgs) {
      buf.writeln('      $a,');
    }

    buf.writeln('    );');
    buf.writeln('  }'); // end factory

    return (importUris, buf);
  }

  Future<(List<Uri>, StringBuffer)> generateCopyWith(ClassElement clazz) async {
    ConstructorElement? ctor;
    for (ConstructorElement c in clazz.constructors) {
      if (c.name.isEmpty) {
        ctor = c;
        break;
      }
    }
    if (ctor == null) return (<Uri>[], StringBuffer());

    // inside generateCopyWith, replace the parameter‑gathering loop
    List<ParameterElement> params = <ParameterElement>[];
    for (ParameterElement p in ctor.parameters) {
      bool matchesField = clazz.getField(p.name) != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }
    if (params.isEmpty) return (<Uri>[], StringBuffer());

    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;

    buf.writeln('  ${clazz.name} copyWith({');

    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;

      String typeCode;
      {
        String base = type.getDisplayString(withNullability: true);
        typeCode = base.endsWith('?') ? base : '$base?';
      }

      buf.writeln('    $typeCode $name,');
      Uri uri = getImport(type, targetLib);
      if (uri.toString().isNotEmpty) importUris.add(uri);
    }
    buf.writeln('  }) '); // end of parameter list, start body

    buf.writeln('    => ${clazz.name}(');
    for (ParameterElement param in params) {
      String name = param.name;
      buf.writeln('      $name: $name ?? this.$name,');
    }
    buf.writeln('    );');

    return (importUris, buf);
  }

  ({String code, List<Uri> imports}) _convert(
    String expr,
    InterfaceType type,
    LibraryElement targetLib,
    _ConvMode mode,
  ) {
    List<Uri> imports = <Uri>[];

    void _addImport(InterfaceType t) {
      Uri uri = ArtifactBuilder().getImport(t, targetLib);
      if (uri.toString().isNotEmpty) imports.add(uri);
    }

    bool nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    String nullOp = nullable ? '?' : '';

    if (_isArtifactInterface(type)) {
      _addImport(type);
      if (mode == _ConvMode.toMap) {
        return (code: '$expr$nullOp.toMap()', imports: imports);
      } else {
        String name = type.element.name;
        return (
          code:
              '\$${name}.fromMap(($expr) as Map<String, dynamic>)${nullable ? '' : ''}',
          imports: imports,
        );
      }
    }

    String elementName = type.element.name;
    if ((elementName == 'List' || elementName == 'Set') &&
        type.typeArguments.length == 1) {
      InterfaceType inner = type.typeArguments.first as InterfaceType;
      if (_isArtifactInterface(inner)) {
        _addImport(inner);
        ({String code, List<Uri> imports}) conv = _convert(
          'e',
          inner,
          targetLib,
          mode,
        ); // recurse
        String fn = elementName == 'List' ? 'toList()' : 'toSet()';
        if (mode == _ConvMode.toMap) {
          return (
            code:
                '$expr$nullOp.map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
            imports: [...imports, ...conv.imports],
          );
        } else {
          return (
            code:
                '($expr as ${elementName}).map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
            imports: [...imports, ...conv.imports],
          );
        }
      }
    }

    if (elementName == 'Map' && type.typeArguments.length == 2) {
      InterfaceType valueT = type.typeArguments[1] as InterfaceType;
      if (_isArtifactInterface(valueT)) {
        _addImport(valueT);
        ({String code, List<Uri> imports}) conv = _convert(
          mode == _ConvMode.fromMap ? 'e.value' : 'v',
          valueT,
          targetLib,
          mode,
        );
        if (mode == _ConvMode.toMap) {
          return (
            code:
                '$expr$nullOp.map((k, v) => MapEntry(k, ${conv.code}))${nullable ? '' : ''}',
            imports: [...imports, ...conv.imports],
          );
        } else {
          return (
            code:
                'Map.fromEntries(($expr as Map).entries.map((e) => MapEntry(e.key, ${conv.code})))${nullable ? '' : ''}',
            imports: [...imports, ...conv.imports],
          );
        }
      }
    }

    return (code: expr, imports: imports);
  }
}

enum _ConvMode { toMap, fromMap }
