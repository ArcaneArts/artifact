import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/artifact.dart';
import 'package:artifact/component/copy_with.dart';
import 'package:artifact/component/from_map.dart';
import 'package:artifact/component/to_map.dart';
import 'package:build/build.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';

typedef $BuildOutput = (List<Uri>, StringBuffer);

extension $BuildOutputL on Iterable<$BuildOutput> {
  $BuildOutput get merged {
    List<Uri> imports = <Uri>[];
    StringBuffer buffer = StringBuffer();
    for ($BuildOutput i in this) {
      imports.addAll(i.$1);
      buffer.write(i.$2);
    }

    return (imports.toSet().toList(), buffer);
  }
}

extension X$BuildOutput on $BuildOutput {
  $BuildOutput mergeWith($BuildOutput other) {
    return (
      [...this.$1, ...other.$1].toSet().toList(),
      StringBuffer()
        ..write(this.$2)
        ..write(other.$2),
    );
  }
}

abstract class $ArtifactBuilderOutput {
  Future<$BuildOutput> onGenerate(ArtifactBuilder builder, ClassElement clazz);
}

class ArtifactBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const <String, List<String>>{
    r'$lib$': <String>['gen/artifacts.gen.dart'],
  };

  static Glob $dartFilesInLib = Glob('lib/**.dart');
  static final TypeChecker $artifactChecker = TypeChecker.fromRuntime(Artifact);
  static final Map<String, List<String>> $artifactSubclasses =
      <String, List<String>>{};

  static void $linkSubclass(ClassElement sub, ClassElement sup) {
    List<String> list = $artifactSubclasses.putIfAbsent(
      sup.name,
      () => <String>[],
    );
    if (!list.contains(sub.name)) list.add(sub.name);
  }

  bool $isArtifactInterface(InterfaceType type) => ArtifactBuilder
      .$artifactChecker
      .hasAnnotationOf(type.element, throwOnUnresolved: false);
  bool useDefs = true;
  Map<String, String> defs = {};
  int ci = 0;

  void registerDef(String typeName) {
    if (defs.values.contains(typeName)) {
      return;
    }

    defs["_${ci.toRadixString(36)}"] = typeName;
    ci++;
  }

  @override
  Future<void> build(BuildStep step) async {
    assert(step.inputId.path == r'$lib$');
    registerDef("ArtifactCodecUtil");
    registerDef("Map<String, dynamic>");
    registerDef("String");
    registerDef("int");
    registerDef("double");
    registerDef("bool");
    registerDef("Duration");
    registerDef("DateTime");
    List<ClassElement> artifacts = <ClassElement>[];

    await for (AssetId asset in step.findAssets($dartFilesInLib)) {
      if (!await step.resolver.isLibrary(asset)) continue;
      LibraryElement lib = await step.resolver.libraryFor(asset);

      for (Element e in lib.topLevelElements) {
        if (e is! ClassElement) continue;
        if (!$artifactChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
          continue;
        }

        registerDef(e.name);

        artifacts.add(e);

        // walk super‑chain, link every annotated ancestor
        InterfaceType? supType = e.supertype;
        while (supType != null) {
          ClassElement sup = supType.element as ClassElement;
          if ($artifactChecker.hasAnnotationOf(sup, throwOnUnresolved: false)) {
            $linkSubclass(e, sup);
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
          ..writeln(
            useDefs
                ? defs.entries
                    .map((i) => "typedef ${i.key} = ${i.value};")
                    .join("\n")
                : "",
          );

    StringBuffer mainBuf = StringBuffer();
    for (StringBuffer cb in classBuffers) {
      mainBuf.writeln(cb);
    }

    String r = mainBuf.toString();
    outBuf.writeln(r);

    AssetId out = AssetId(step.inputId.package, 'lib/gen/artifacts.gen.dart');
    await step.writeAsString(out, outBuf.toString());
  }

  Uri $getImport(InterfaceType type, LibraryElement targetLib) {
    LibraryElement definingLib = type.element.library!;
    Uri importUri = definingLib.source.uri; // eg. package:resilient_models/…
    if (definingLib == targetLib) return Uri(); // empty = skip
    return importUri;
  }

  Future<$BuildOutput> generate(ClassElement clazz) async => (
        <Uri>[],
        StringBuffer()
          ..writeln("extension \$${clazz.name} on ${applyDefsF(clazz.name)} {")
          ..writeln("  ${applyDefsF(clazz.name)} get _t => this;"),
      )
      .mergeWith(
        await Future.wait([
          const $ArtifactToMapComponent().onGenerate(this, clazz),
          const $ArtifactFromMapComponent().onGenerate(this, clazz),
          const $ArtifactCopyWithComponent().onGenerate(this, clazz),
        ]).then((i) => i.merged),
      )
      .mergeWith((<Uri>[], StringBuffer()..write("}")));

  ({String code, List<Uri> imports}) $convert(
    String expr,
    InterfaceType type,
    LibraryElement targetLib,
    $ArtifactConvertMode mode,
  ) {
    List<Uri> imports = <Uri>[];

    void _addImport(InterfaceType t) {
      Uri uri = ArtifactBuilder().$getImport(t, targetLib);
      if (uri.toString().isNotEmpty) imports.add(uri);
    }

    bool nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    String nullOp = nullable ? '?' : '';

    if ($isArtifactInterface(type)) {
      _addImport(type);
      if (mode == $ArtifactConvertMode.toMap) {
        return (code: applyDefs(' $expr$nullOp.toMap()'), imports: imports);
      } else {
        String name = type.element.name;
        return (
          code: applyDefs(
            ' \$${name}.fromMap(($expr) as ${applyDefsF("Map<String, dynamic>")})${nullable ? '' : ''}',
          ),
          imports: imports,
        );
      }
    }

    String elementName = type.element.name;
    if ((elementName == 'List' || elementName == 'Set') &&
        type.typeArguments.length == 1) {
      InterfaceType inner = type.typeArguments.first as InterfaceType;
      if ($isArtifactInterface(inner)) {
        _addImport(inner);
        ({String code, List<Uri> imports}) conv = $convert(
          'e',
          inner,
          targetLib,
          mode,
        ); // recurse
        String fn = elementName == 'List' ? 'toList()' : 'toSet()';
        if (mode == $ArtifactConvertMode.toMap) {
          return (
            code: applyDefs(
              ' $expr$nullOp.map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
            ),
            imports: [...imports, ...conv.imports],
          );
        } else {
          return (
            code: applyDefs(
              ' ($expr as ${applyDefsF(elementName)}).map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
            ),
            imports: [...imports, ...conv.imports],
          );
        }
      }
    }

    if (elementName == 'Map' && type.typeArguments.length == 2) {
      InterfaceType valueT = type.typeArguments[1] as InterfaceType;
      if ($isArtifactInterface(valueT)) {
        _addImport(valueT);
        ({String code, List<Uri> imports}) conv = $convert(
          mode == $ArtifactConvertMode.fromMap ? 'e.value' : 'v',
          valueT,
          targetLib,
          mode,
        );
        if (mode == $ArtifactConvertMode.toMap) {
          return (
            code: applyDefs(
              ' $expr$nullOp.map((k, v) => ${applyDefsF("MapEntry")}(k, ${conv.code}))${nullable ? '' : ''}',
            ),
            imports: [...imports, ...conv.imports],
          );
        } else {
          return (
            code: applyDefs(
              ' Map.fromEntries(($expr as ${applyDefsF("Map")}).\$e.\$m((e) => ${applyDefsF("MapEntry")}(e.key, ${conv.code})))${nullable ? '' : ''}',
            ),
            imports: [...imports, ...conv.imports],
          );
        }
      }
    }

    if (mode == $ArtifactConvertMode.toMap) {
      return (
        code: applyDefs(' ArtifactCodecUtil.ea($expr)'),
        imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
      );
    } else {
      return (
        code: applyDefs(
          ' ArtifactCodecUtil.da($expr, ${type.element.name}) as ${applyDefsF(type.element.name)}${nullable ? '' : ''}',
        ),
        imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
      );
    }
  }

  String applyDefsF(String sr) {
    sr = applyDefs(" ${sr} ").substring(1);
    sr = sr.substring(0, sr.length - 1);
    return sr;
  }

  String applyDefs(String sr) {
    if (!useDefs) return sr;

    for (String i in defs.keys) {
      String def = defs[i]!;
      sr = sr.replaceAll(" $def ", " $i ");
      sr = sr.replaceAll(" $def.", " $i.");
    }

    return sr;
  }
}

enum $ArtifactConvertMode { toMap, fromMap }
