import 'dart:async';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/artifact.dart';
import 'package:artifact_gen/component/attach.dart';
import 'package:artifact_gen/component/copy_with.dart';
import 'package:artifact_gen/component/from_map.dart';
import 'package:artifact_gen/component/reflector.dart';
import 'package:artifact_gen/component/schema.dart';
import 'package:artifact_gen/component/to_map.dart';
import 'package:artifact_gen/converter.dart';
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

  late final ArtifactTypeConverter converter;
  static Glob $dartFilesInLib = Glob('lib/**.dart');
  static final TypeChecker $artifactChecker = TypeChecker.fromRuntime(Artifact);
  static final TypeChecker $codecChecker = TypeChecker.fromRuntime(codec);
  static final TypeChecker $describeChecker = TypeChecker.fromRuntime(describe);
  static final TypeChecker $renameChecker = TypeChecker.fromRuntime(rename);
  static final Map<String, ClassElement> $iClassMap = {};
  static final Map<String, List<String>> $artifactSubclasses = {};

  static void $linkSubclass(ClassElement sub, ClassElement sup) {
    List<String> list = $artifactSubclasses.putIfAbsent(
      sup.name,
      () => <String>[],
    );
    if (!list.contains(sub.name)) list.add(sub.name);
  }

  ArtifactBuilder() {
    converter = ArtifactTypeConverter(this);
  }

  bool $isEnum(InterfaceType type) =>
      type.element is EnumElement || type.element.kind == ElementKind.ENUM;

  bool $isArtifactInterface(InterfaceType type) => ArtifactBuilder
      .$artifactChecker
      .hasAnnotationOf(type.element, throwOnUnresolved: false);

  Map<String, String> defs = {};
  List<String> strDD = [];
  List<String> valDD = [];
  int ci = 0;

  void registerDef(String typeName) {
    if (typeName.startsWith("_")) {
      return;
    }

    if (defs.values.contains(typeName)) {
      return;
    }

    defs["_${ci.toRadixString(36)}"] = typeName;
    ci++;
  }

  String stringD(String at) {
    if (compression && at.length > 3) {
      int? index = strDD.indexOf(at);
      if (index == -1) {
        strDD.add(at);
        index = strDD.length - 1;
      }
      return "_S[$index]";
    }

    return "'$at'";
  }

  String valD(String at, DartType th) {
    at = at.trim();
    if (compression && at.length > 3) {
      String ds = th.getDisplayString();
      if ((ds.startsWith("Set<") ||
              ds.startsWith("Map<") ||
              ds.startsWith("List<")) &&
          (at.endsWith("}") || at.endsWith("]"))) {
        at = " $at ".replaceAll(" const ", "").trim();
        String fa = (th as InterfaceType).typeArguments[0].getDisplayString(
          withNullability: false,
        );
        registerDef(fa);
        String fa1 =
            "${applyDefsF(fa)}${th.typeArguments[0].getDisplayString(withNullability: true).endsWith("?") ? "?" : ""}";
        if (ds.startsWith("Set<")) {
          at = "<$fa1>$at";
        } else if (ds.startsWith("List<")) {
          at = "<$fa1>$at";
        } else if (ds.startsWith("Map<")) {
          String sa = th.typeArguments[1].getDisplayString(
            withNullability: false,
          );
          registerDef(sa);
          String sa1 =
              "${applyDefsF(sa)}${th.typeArguments[1].getDisplayString(withNullability: true).endsWith("?") ? "?" : ""}";
          at = "<$fa1,$sa1>$at";
        }
      }

      int? index = valDD.indexOf(at);
      if (index == -1) {
        valDD.add(at);
        index = valDD.length - 1;
      }
      return "_V[$index]";
    }

    return "$at";
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
    List<ClassElement> artifacts = <ClassElement>[];

    await for (AssetId asset in step.findAssets($dartFilesInLib)) {
      if (!await step.resolver.isLibrary(asset)) continue;
      LibraryElement lib = await step.resolver.libraryFor(asset);

      for (Element e in lib.topLevelElements) {
        if (e is! ClassElement) continue;
        $iClassMap[e.name] = e;
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

    String codecRegistry = "const ${applyDefsF("int")} _ = 0;";
    if (codecs.isNotEmpty) {
      StringBuffer sb = StringBuffer();
      sb.write("${applyDefsF("int")} _ = ((){");
      sb.write(
        "${applyDefsF("ArtifactCodecUtil")}.r(const [${codecs.join(",")}]);",
      );
      sb.write("return 0;");
      sb.write("})();");
      codecRegistry = sb.toString();
    }

    await Future.wait(work);
    registerDef("List<dynamic>");
    imports.add(Uri.parse("package:artifact/artifact.dart"));
    StringBuffer outBuf =
        StringBuffer()
          ..writeln('// GENERATED – do not modify by hand\n')
          ..writeln(
            [
              "camel_case_types",
              "non_constant_identifier_names",
              "constant_identifier_names",
              "library_private_types_in_public_api",
              "unused_element",
            ].map((i) => "// ignore_for_file: $i").join("\n"),
          )
          ..writeln(
            imports
                .where((i) => i.toString().trim().isNotEmpty)
                .map((i) => 'import "$i";')
                .toSet()
                .toList()
                .join(),
          )
          ..writeln(
            compression
                ? defs.entries.map((i) => "typedef ${i.key}=${i.value};").join()
                : "",
          )
          ..write(
            compression
                ? "const ${applyDefsF("List<String>")} _S=[${strDD.map((i) => "'$i'").join(",")}];"
                : "",
          )
          ..write(
            compression
                ? "const ${applyDefsF("List<dynamic>")} _V=[${valDD.map((i) => " $i ".replaceAll(" const ", "").trim()).join(",")}];"
                : "",
          )
          ..write("const ${applyDefsF("bool")} _T=true;")
          ..write("const ${applyDefsF("bool")} _F=false;")
          ..writeln(codecRegistry);

    StringBuffer mainBuf = StringBuffer();
    for (StringBuffer cb in classBuffers) {
      mainBuf.writeln(cb);
    }

    String r = mainBuf.toString();
    outBuf.writeln(r);
    outBuf.write(
      "bool \$isArtifact(dynamic v)=>v==null?false : v is! Type ?\$isArtifact(v.runtimeType):",
    );

    for (ClassElement i in artifacts) {
      outBuf.write(
        "v == ${applyDefsF(i.name)} ${i == artifacts.last ? "" : "||"}",
      );
    }

    outBuf.writeln(";");

    outBuf.write("T \$constructArtifact<T>() => ");

    for (ClassElement i in artifacts) {
      outBuf.write(
        "T==${applyDefsF(i.name)} ?\$${(i.name)}.newInstance as T ${i == artifacts.last ? "" : ":"}",
      );
    }

    outBuf.writeln(": throw Exception();");

    outBuf.write(
      "${applyDefsF("Map<String, dynamic>")} \$artifactToMap(Object o)=>",
    );

    for (ClassElement i in artifacts) {
      outBuf.write(
        "o is ${applyDefsF(i.name)} ?o.toMap()${i == artifacts.last ? "" : ":"}",
      );
    }

    outBuf.writeln(":throw Exception();");

    outBuf.write(
      "T \$artifactFromMap<T>(${applyDefsF("Map<String, dynamic>")} m)=>",
    );

    for (ClassElement i in artifacts) {
      outBuf.write(
        "T==${applyDefsF(i.name)} ?\$${i.name}.fromMap(m) as T${i == artifacts.last ? "" : ":"}",
      );
    }

    outBuf.writeln(": throw Exception();");

    AssetId out = AssetId(step.inputId.package, 'lib/gen/artifacts.gen.dart');
    await step.writeAsString(out, outBuf.toString());
  }

  Uri $getImport(DartType type, LibraryElement targetLib) {
    if (type is InterfaceType) {
      if (identical(type.element.library, targetLib)) return Uri();

      Uri uri = type.element.source.uri;

      if (uri.scheme == 'dart') {
        String libName = uri.pathSegments.first; // 'core'
        return Uri(scheme: 'dart', path: libName); // dart:core
      }

      return uri;
    }

    return Uri();
  }

  bool compression = true;

  Future<$BuildOutput> generate(ClassElement clazz) async {
    compression =
        $artifactChecker
            .firstAnnotationOf(clazz, throwOnUnresolved: false)
            ?.getField("compression")
            ?.toBoolValue() ??
        false;

    return (
          <Uri>[],
          StringBuffer()
            ..writeln("extension \$${clazz.name} on ${applyDefsF(clazz.name)}{")
            ..writeln("  ${applyDefsF(clazz.name)} get _H=>this;"),
        )
        .mergeWith(
          await Future.wait([
            const $ArtifactToMapComponent().onGenerate(this, clazz),
            const $ArtifactFromMapComponent().onGenerate(this, clazz),
            const $ArtifactCopyWithComponent().onGenerate(this, clazz),
            const $ArtifactAttachComponent().onGenerate(this, clazz),
            if ($artifactChecker
                    .firstAnnotationOf(clazz, throwOnUnresolved: false)
                    ?.getField("reflection")
                    ?.toBoolValue() ??
                false)
              const $ArtifactReflectorComponent().onGenerate(this, clazz),
            if ($artifactChecker
                    .firstAnnotationOf(clazz, throwOnUnresolved: false)
                    ?.getField("generateSchema")
                    ?.toBoolValue() ??
                false)
              const $ArtifactSchemaComponent().onGenerate(this, clazz),
          ]).then((i) => i.merged),
        )
        .mergeWith((<Uri>[], StringBuffer()..write("}")));
  }

  String applyDefsF(String sr) {
    sr = applyDefs(" ${sr} ").substring(1);
    sr = sr.substring(0, sr.length - 1);
    return sr;
  }

  String applyDefs(String sr) {
    if (!compression) return sr;

    for (String i in defs.keys) {
      String def = defs[i]!;
      sr = sr.replaceAll(" $def ", " $i ");
      sr = sr.replaceAll(" $def.", " $i.");
    }

    return sr;
  }
}

enum $ArtifactConvertMode { toMap, fromMap }
