import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
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
import 'package:toxic/extensions/iterable.dart';

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
  static final TypeChecker $codecChecker = TypeChecker.fromRuntime(codec);
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
  List<String> strDD = [];
  int ci = 0;

  void registerDef(String typeName) {
    if (defs.values.contains(typeName)) {
      return;
    }

    defs["_${ci.toRadixString(36)}"] = typeName;
    ci++;
  }

  String stringD(String at) {
    if (useDefs && at.length > 3) {
      int? index = strDD.indexOf(at);
      if (index == -1) {
        strDD.add(at);
        index = strDD.length - 1;
      }
      return "_S[$index]";
    }

    return "'$at'";
  }

  @override
  Future<void> build(BuildStep step) async {
    assert(step.inputId.path == r'$lib$');
    registerDef("ArtifactCodecUtil");
    registerDef("Map<String, dynamic>");
    registerDef("List<String>");
    registerDef("String");
    registerDef("dynamic");
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
    List<String> codecs = [];

    for (ClassElement art in artifacts) {
      imports.add(art.source.uri);
      work.add(
        generate(art).then((v) {
          imports.addAll(v.$1);
          classBuffers.add(v.$2);
        }),
      );

      codecs.addAll(
        $codecChecker
            .annotationsOf(art, throwOnUnresolved: false)
            .followedBy(
              art.fields.expand(
                (j) => $codecChecker.annotationsOf(j, throwOnUnresolved: false),
              ),
            )
            .followedBy(
              art.methods.expand(
                (j) => $codecChecker.annotationsOf(j, throwOnUnresolved: false),
              ),
            )
            .followedBy(
              art.constructors.expand(
                (j) => $codecChecker.annotationsOf(j, throwOnUnresolved: false),
              ),
            )
            .map((i) => i.getField("c"))
            .whereType<DartObject>()
            .map((i) {
              imports.add($getImport(i.type as InterfaceType, art.library));

              return i.type?.getDisplayString(withNullability: false);
            })
            .whereType<String>()
            .unique
            .map((i) {
              registerDef(i);
              return "${applyDefsF(i)}()";
            }),
      );
    }

    String codecRegistry = "${applyDefsF("int")} _ = 0;";
    if (codecs.isNotEmpty) {
      StringBuffer sb = StringBuffer();
      sb.writeln("${applyDefsF("int")} _ = ((){");
      sb.writeln(
        "  ${applyDefsF("ArtifactCodecUtil")}.r(const [${codecs.join(",")}]);",
      );
      sb.writeln("  return 0;");
      sb.writeln("})();");
      codecRegistry = sb.toString();
    }

    await Future.wait(work);

    StringBuffer outBuf =
        StringBuffer()
          ..writeln('// GENERATED – do not modify by hand\n')
          ..writeln(
            [
              "camel_case_types",
              "library_private_types_in_public_api",
            ].map((i) => "// ignore_for_file: $i").join("\n"),
          )
          ..writeln(
            imports
                .where((i) => i.toString().trim().isNotEmpty)
                .map((i) => 'import "$i";')
                .toSet()
                .toList()
                .join('\n'),
          )
          ..writeln(
            useDefs
                ? defs.entries
                    .map((i) => "typedef ${i.key} = ${i.value};")
                    .join("\n")
                : "",
          )
          ..writeln(
            useDefs
                ? "${applyDefsF("List<String>")} _S = [${strDD.map((i) => "'$i'").join(",")}];"
                : "",
          )
          ..writeln(codecRegistry);

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
    // Same-library element → nothing to import.
    if (identical(type.element.library, targetLib)) return Uri();

    Uri uri = type.element.source.uri;

    if (uri.scheme == 'dart') {
      String libName = uri.pathSegments.first; // 'core'
      return Uri(scheme: 'dart', path: libName); // dart:core
    }

    return uri;
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
      Uri uri = $getImport(t, targetLib);
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
      if ($isArtifactInterface(inner)) {}

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
        registerDef(elementName);
        return (
          code: applyDefs(
            ' ($expr as ${applyDefsF(elementName)}).map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      }
    }

    if (elementName == 'Map' && type.typeArguments.length == 2) {
      InterfaceType valueT = type.typeArguments[1] as InterfaceType;
      if ($isArtifactInterface(valueT)) {}

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
        registerDef("MapEntry");
        return (
          code: applyDefs(
            ' Map.fromEntries(($expr as ${applyDefsF("Map")}).\$e.\$m((e) => ${applyDefsF("MapEntry")}(e.key, ${conv.code})))${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      }
    }

    if (mode == $ArtifactConvertMode.toMap) {
      return (
        code: applyDefs(' ArtifactCodecUtil.ea($expr)'),
        imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
      );
    } else {
      registerDef(type.element.name);
      return (
        code: applyDefs(
          ' ArtifactCodecUtil.da($expr, ${applyDefsF(type.element.name)}) as ${applyDefsF(type.element.name)}${nullable ? '?' : ''}',
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
