import 'dart:async';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/syntactic_entity.dart';
import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/artifact.dart';
import 'package:artifact_gen/component/copy_with.dart';
import 'package:artifact_gen/component/from_map.dart';
import 'package:artifact_gen/component/instance.dart';
import 'package:artifact_gen/component/reflector.dart';
import 'package:artifact_gen/component/schema.dart';
import 'package:artifact_gen/component/to_map.dart';
import 'package:artifact_gen/converter.dart';
import 'package:artifact_gen/util.dart';
import 'package:build/build.dart';
import 'package:fast_log/fast_log.dart';
import 'package:glob/glob.dart';
import 'package:source_gen/source_gen.dart';
import 'package:toxic/extensions/iterable.dart';
import 'package:yaml/yaml.dart';

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

mixin $ArtifactBuilderOutput {
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement constructor,
    List<FormalParameterElement> params,
    BuildStep step,
    List<String>? eFields,
  );

  String paramName(FormalParameterElement param) => param.name ?? "";

  String baseTypeOf(DartType type) =>
      type.getDisplayString(withNullability: false);

  bool isNullableType(DartType type) =>
      type.getDisplayString(withNullability: true).endsWith("?");

  bool isCollectionType(String baseType) =>
      baseType.startsWith("List<") || baseType.startsWith("Set<");

  bool isNumericType(String baseType) =>
      baseType == "int" || baseType == "double";

  bool supportsDeleteFlag(FormalParameterElement param) =>
      param.isOptionalNamed && isNullableType(param.type);

  String subclassTagFor(ClassElement clazz) => '_subclass_${clazz.name ?? ""}';
}

class ArtifactBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => const <String, List<String>>{
    r'$lib$': <String>['gen/artifacts.gen.dart', 'gen/exports.gen.dart'],
  };

  late final ArtifactTypeConverter converter;
  static Glob $dartFilesInLib = Glob('lib/**.dart');
  static final TypeChecker $artifactChecker = TypeChecker.typeNamed(Artifact);
  static final TypeChecker $encryptChecker = TypeChecker.typeNamed(
    ArtifactEncrypt,
  );
  static final TypeChecker $codecChecker = TypeChecker.typeNamed(codec);
  static final TypeChecker $describeChecker = TypeChecker.typeNamed(describe);
  static final TypeChecker $renameChecker = TypeChecker.typeNamed(rename);
  static final Map<String, ClassElement> $iClassMap = {};
  static final Map<String, List<String>> $artifactSubclasses = {};
  Map<String, dynamic> artifactConfig = {};

  static void $linkSubclass(ClassElement sub, ClassElement sup) {
    List<String> list = $artifactSubclasses.putIfAbsent(
      sup.name ?? "",
      () => <String>[],
    );
    if (!list.contains(sub.name)) list.add(sub.name ?? "");
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

  Never throwGenerationFailure({
    required ClassElement clazz,
    required String stage,
    FormalParameterElement? param,
    required Object error,
    StackTrace? stackTrace,
  }) {
    String className = clazz.name ?? "<unnamed>";
    String location = "Artifact generation failed at $stage for $className";
    if (param?.name != null) {
      location = "$location.${param!.name}";
    }

    String details = "$location: $error";
    if (stackTrace != null) {
      details = "$details\n$stackTrace";
    }

    throw InvalidGenerationSourceError(
      details,
      element: param ?? clazz,
      todo:
          "Inspect the failing component/stage in artifact_gen and the referenced class/parameter.",
    );
  }

  T guardGeneration<T>({
    required ClassElement clazz,
    required String stage,
    FormalParameterElement? param,
    required T Function() run,
  }) {
    try {
      return run();
    } on InvalidGenerationSourceError {
      rethrow;
    } catch (e, st) {
      throwGenerationFailure(
        clazz: clazz,
        stage: stage,
        param: param,
        error: e,
        stackTrace: st,
      );
    }
  }

  Future<T> guardGenerationAsync<T>({
    required ClassElement clazz,
    required String stage,
    FormalParameterElement? param,
    required Future<T> Function() run,
  }) async {
    try {
      return await run();
    } on InvalidGenerationSourceError {
      rethrow;
    } catch (e, st) {
      throwGenerationFailure(
        clazz: clazz,
        stage: stage,
        param: param,
        error: e,
        stackTrace: st,
      );
    }
  }

  @override
  Future<void> build(BuildStep step) async {
    try {
      Map<String, dynamic> pubspec = Map<String, dynamic>.from(
        loadYaml(File("pubspec.yaml").readAsStringSync()),
      );
      artifactConfig =
          Map<String, dynamic>.from(pubspec["artifact"] ?? {}) ?? {};
      artifactConfig["name"] = pubspec["name"] ?? "unknown_package";
      verbose("Loaded Config ${artifactConfig}");
    } catch (e) {
      error(e);
      warn(
        "Couldn't read ${File("pubspec.yaml").absolute.path} for configuration defaults! Using built-in defaults. Override with @Artifact(...) annotations only.",
      );
      artifactConfig = {"name": "couldnt_find_pubspec"};
    }

    assert(step.inputId.path == r'$lib$');
    registerDef("ArtifactCodecUtil");
    registerDef("ArtifactDataUtil");
    registerDef("ArtifactSecurityUtil");
    registerDef("ArtifactReflection");
    registerDef("ArtifactMirror");
    registerDef("Map<String,dynamic>");
    registerDef("List<String>");
    registerDef("String");
    registerDef("dynamic");
    registerDef("int");
    registerDef("ArtifactModelExporter");
    registerDef("ArgumentError");
    registerDef("Exception");
    List<ClassElement> artifacts = <ClassElement>[];

    await for (AssetId asset in step.findAssets($dartFilesInLib)) {
      if (!await step.resolver.isLibrary(asset)) continue;
      LibraryElement lib = await step.resolver.libraryFor(asset);

      for (Element e in lib.classes) {
        if (e is! ClassElement) continue;
        $iClassMap[e.name ?? ""] = e;
        if (!$artifactChecker.hasAnnotationOf(e, throwOnUnresolved: false)) {
          continue;
        }

        registerDef(e.name ?? "");

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
      imports.add(art.library.uri);
      work.add(
        generate(art, step).then((v) {
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

    String codecRegistry = "const ${applyDefsF("int")} _=0;";

    registerDef("ArtifactAccessor");
    StringBuffer sb = StringBuffer();
    sb.write("${applyDefsF("int")} _ = ((){");
    if (codecs.isNotEmpty) {
      sb.write(
        "${applyDefsF("ArtifactCodecUtil")}.r(const [${codecs.join(",")}]);",
      );
    }

    sb.write(
      "if(!${applyDefsF("ArtifactAccessor")}.\$i(${stringD(step.inputId.package)})){${applyDefsF("ArtifactAccessor")}.\$r(${stringD(step.inputId.package)},${applyDefsF("ArtifactAccessor")}(isArtifact: \$isArtifact,artifactMirror:${artifacts.any((c) => $artifactChecker.firstAnnotationOf(c, throwOnUnresolved: false)?.getField("reflection")?.toBoolValue() ?? false) ? "\$artifactMirror" : "{}"},constructArtifact:\$constructArtifact,artifactToMap:\$artifactToMap,artifactFromMap:\$artifactFromMap));}",
    );
    sb.write("return 0;");
    sb.writeln("})();");
    codecRegistry = sb.toString();
    StringBuffer rbuf = StringBuffer();
    if (artifacts.any(
      (c) =>
          $artifactChecker
              .firstAnnotationOf(c, throwOnUnresolved: false)
              ?.getField("reflection")
              ?.toBoolValue() ??
          false,
    )) {
      registerDef("\$AClass");
      rbuf.write(
        "Map<Type,${applyDefsF("\$AClass")}> get \$artifactMirror => {",
      );

      for (ClassElement i in artifacts) {
        if ($artifactChecker
                .firstAnnotationOf(i, throwOnUnresolved: false)
                ?.getField("reflection")
                ?.toBoolValue() ??
            false) {
          registerDef(applyDefsF(i.supertype!.element.name ?? ""));

          for (String i in i.interfaces.map((i) => i.element.name ?? "")) {
            registerDef(i);
          }

          for (String i in i.mixins.map((i) => i.element.name ?? "")) {
            registerDef(i);
          }

          for (InterfaceType i in i.allSupertypes) {
            imports.add(i.element.library.uri);
          }

          registerDef("\$AClass<${i.name ?? ""}>");
          rbuf.write(applyDefsF(i.name ?? ""));
          rbuf.write(":");
          rbuf.write(applyDefsF("\$AClass<${i.name ?? ""}>("));
          rbuf.write("\$${i.name}.\$annotations,");
          rbuf.write("\$${i.name}.\$fields,");
          rbuf.write("\$${i.name}.\$methods,");
          rbuf.write("()=>\$${i.name}.newInstance,");
          rbuf.write("${applyDefsF(i.supertype!.element.name ?? "")},");
          rbuf.write(
            "[${i.interfaces.map((i) => applyDefsF(i.element.name ?? "")).join(",")}],",
          );
          rbuf.write(
            "[${i.mixins.map((i) => applyDefsF(i.element.name ?? "")).join(",")}],",
          );
          rbuf.write("${typeDescriptorCode(i.thisType, this)},");
          rbuf.write("),");
        }
      }

      rbuf.writeln("};");
    }

    /// int _v = _register();
    //
    // int _register() {
    //   ArtifactAccessor.register(
    //     "something",
    //     ArtifactAccessor(
    //       isArtifact: $isArtifact,
    //       artifactMirror: $artifactMirror,
    //       constructArtifact: $constructArtifact,
    //       artifactToMap: $artifactToMap,
    //       artifactFromMap: $artifactFromMap,
    //     ),
    //   );
    //   return 0;
    // }

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
          ..writeln(
            "${applyDefsF("ArgumentError")} __x(${applyDefsF("String")} c,${applyDefsF("String")} f)=>${applyDefsF("ArgumentError")}('\${${stringD("Missing required ")}}\$c.\$f');",
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

    if (artifacts.isEmpty) {
      outBuf.writeln("bool \$isArtifact(dynamic v)=>false;");
    } else {
      outBuf.write(
        "bool \$isArtifact(dynamic v)=>v==null?false : v is! Type ?\$isArtifact(v.runtimeType):",
      );

      for (ClassElement i in artifacts) {
        outBuf.write(
          "v == ${applyDefsF(i.name ?? "")} ${i == artifacts.last ? "" : "||"}",
        );
      }

      outBuf.writeln(";");
    }

    outBuf.write(rbuf);

    if (artifacts.isEmpty) {
      outBuf.writeln(
        "T \$constructArtifact<T>() => throw ${applyDefsF("Exception")}();",
      );
    } else {
      outBuf.write("T \$constructArtifact<T>() => ");

      for (ClassElement i in artifacts) {
        outBuf.write(
          "T==${applyDefsF(i.name ?? "")} ?\$${(i.name)}.newInstance as T ${i == artifacts.last ? "" : ":"}",
        );
      }

      outBuf.writeln(": throw ${applyDefsF("Exception")}();");
    }

    if (artifacts.isEmpty) {
      outBuf.writeln(
        "${applyDefsF("Map<String,dynamic>")} \$artifactToMap(Object o)=>throw ${applyDefsF("Exception")}();",
      );
    } else {
      outBuf.write(
        "${applyDefsF("Map<String,dynamic>")} \$artifactToMap(Object o)=>",
      );

      for (ClassElement i in artifacts) {
        outBuf.write(
          "o is ${applyDefsF(i.name ?? "")} ?o.toMap()${i == artifacts.last ? "" : ":"}",
        );
      }

      outBuf.writeln(":throw ${applyDefsF("Exception")}();");
    }

    if (artifacts.isEmpty) {
      outBuf.writeln(
        "T \$artifactFromMap<T>(${applyDefsF("Map<String,dynamic>")} m)=>throw ${applyDefsF("Exception")}();",
      );
    } else {
      outBuf.write(
        "T \$artifactFromMap<T>(${applyDefsF("Map<String,dynamic>")} m)=>",
      );

      for (ClassElement i in artifacts) {
        outBuf.write(
          "T==${applyDefsF(i.name ?? "")} ?\$${i.name}.fromMap(m) as T${i == artifacts.last ? "" : ":"}",
        );
      }

      outBuf.writeln(":throw ${applyDefsF("Exception")}();");
    }
    AssetId out = AssetId(step.inputId.package, 'lib/gen/artifacts.gen.dart');
    await step.writeAsString(out, outBuf.toString());

    bool autoExport = artifactConfig["export"] ?? false;
    Stream<AssetId> assets = step.findAssets(Glob('lib/**.dart'));

    List<Future<String?>> worker = [];
    await for (AssetId i in assets) {
      String exportUri = i.uri.path;

      if (exportUri != '${artifactConfig["name"]}/gen/exports.gen.dart' &&
          exportUri !=
              '${artifactConfig["name"]}/${artifactConfig["name"]}.dart') {
        bool readable = await step.canRead(i);
        if (!readable) {
          verbose("Skipping unreadable export analysis for: ${i.uri}");
          continue;
        }

        worker.add(
          step.readAsString(i).then((v) {
            Iterable<SyntacticEntity> ast =
                parseString(content: v).unit.childEntities;

            for (SyntacticEntity j in ast) {
              if (j is PartOfDirective) {
                return null;
              }
            }

            return getExpString(ast, exportUri, autoExport);
          }),
        );
      } else {
        verbose("Skipping export analysis for: ${i.uri}");
      }
    }

    List<String> s = (await Future.wait(worker)).whereType<String>().toList();
    s.add("export 'artifacts.gen.dart';");
    if (s.isNotEmpty) {
      AssetId outExports = AssetId(
        step.inputId.package,
        'lib/gen/exports.gen.dart',
      );
      await step.writeAsString(outExports, s.join("\n"));
    } else {
      warn("No exports generated.");
    }
  }

  String? getExpString(
    Iterable<SyntacticEntity> ast,
    String exportUri,
    bool def,
  ) {
    int ignoreCount = 0;
    int exportCount = 0;
    List<String> ignoreList = <String>[];
    List<String> exportList = <String>[];
    List<String> normalList = <String>[];

    ast.whereType<NamedCompilationUnitMember>().forEach((e) {
      Iterable<String> meta = e.metadata.map((e) => e.toString());
      if (meta.contains('@internal')) {
        ignoreCount++;
        ignoreList.add(e.name.toString());
      } else if (meta.contains('@external')) {
        exportCount++;
        exportList.add(e.name.toString());
      } else {
        normalList.add(e.name.toString());
      }
    });

    ast.whereType<TopLevelVariableDeclaration>().forEach((e) {
      Iterable<String> meta = e.metadata.map((e) => e.toString());
      if (meta.contains('@internal')) {
        ignoreCount++;
        ignoreList.add(e.variables.variables.first.name.toString());
      } else if (meta.contains('@external')) {
        exportCount++;
        exportList.add(e.variables.variables.first.name.toString());
      } else {
        normalList.add(e.variables.variables.first.name.toString());
      }
    });

    if (def) {
      if (ignoreCount == 0) {
        return "export 'package:$exportUri';";
      }

      String toExpLst = [...normalList, ...exportList].join(', ');
      if (toExpLst.isNotEmpty) {
        return "export 'package:$exportUri' show $toExpLst;";
      } else {
        return null;
      }
    } else {
      if (exportCount == 0) {
        return null;
      }

      String toExpLst = exportList.join(',');
      return "export 'package:$exportUri' show $toExpLst;";
    }
  }

  Uri $getImport(DartType type, LibraryElement targetLib) {
    if (type is InterfaceType) {
      if (identical(type.element.library, targetLib)) return Uri();

      Uri uri = type.element.library.uri;

      if (uri.scheme == 'dart') {
        String libName = uri.pathSegments.first; // 'core'
        return Uri(scheme: 'dart', path: libName); // dart:core
      }

      return uri;
    }

    return Uri();
  }

  bool compression = true;

  Future<$BuildOutput> generate(ClassElement clazz, BuildStep step) async {
    compression =
        $artifactChecker
            .firstAnnotationOf(clazz, throwOnUnresolved: false)
            ?.getField("compression")
            ?.toBoolValue() ??
        false;

    ConstructorElement? ctor = clazz.defaultConstructor;
    if (ctor == null) return (<Uri>[], StringBuffer());
    List<FormalParameterElement> params = ctor.aParams;
    List<String>? eAFields;
    Set<String> eFields = {};
    Set<String> rFields = {};
    DartObject? eAnn = $encryptChecker.firstAnnotationOf(
      clazz,
      throwOnUnresolved: false,
    );

    if (eAnn != null) {
      if (eAnn.getField("encrypt")?.toBoolValue() == true) {
        eFields = params.map((i) => i.name).whereType<String>().toSet();
      } else {
        rFields = params.map((i) => i.name).whereType<String>().toSet();
      }
    }

    for (FormalParameterElement p in params) {
      if (p.name == null) {
        continue;
      }
      FieldElement? f = clazz.getField(p.name!);

      if (f == null) {
        continue;
      }

      DartObject? pAnn = $encryptChecker.firstAnnotationOf(
        f,
        throwOnUnresolved: false,
      );
      if (pAnn != null) {
        if (pAnn.getField("encrypt")?.toBoolValue() == true && p.name != null) {
          eFields.add(p.name!);
        } else if (p.name != null) {
          rFields.add(p.name!);
        }
      }
    }

    if (eFields.isNotEmpty || rFields.isNotEmpty) {
      eAFields =
          params.map((i) => i.name).whereType<String>().diff(eFields).toList();
    }

    Future<$BuildOutput> _component(
      String name,
      $ArtifactBuilderOutput component,
    ) {
      return guardGenerationAsync(
        clazz: clazz,
        stage: "component:$name",
        run:
            () =>
                component.onGenerate(this, clazz, ctor, params, step, eAFields),
      );
    }

    return (
          <Uri>[],
          StringBuffer()
            ..writeln(
              "extension \$${clazz.name} on ${applyDefsF(clazz.name ?? "")}{",
            )
            ..writeln("  ${applyDefsF(clazz.name ?? "")} get _H=>this;"),
        )
        .mergeWith(
          await Future.wait([
            _component("to_map", const $ArtifactToMapComponent()),
            _component("from_map", const $ArtifactFromMapComponent()),
            _component("copy_with", const $ArtifactCopyWithComponent()),
            _component("instance", const $ArtifactInstanceComponent()),
            if ($artifactChecker
                    .firstAnnotationOf(clazz, throwOnUnresolved: false)
                    ?.getField("reflection")
                    ?.toBoolValue() ??
                false)
              _component("reflector", const $ArtifactReflectorComponent()),
            if ($artifactChecker
                    .firstAnnotationOf(clazz, throwOnUnresolved: false)
                    ?.getField("generateSchema")
                    ?.toBoolValue() ??
                false)
              _component("schema", const $ArtifactSchemaComponent()),
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

String getTypeName(DartType type) {
  String display = type.getDisplayString(withNullability: true);
  if (display != "InvalidType") return display;

  return type.element?.name ?? type.element?.displayName ?? 'InvalidType';
}

String typeDescriptorCode(DartType type, ArtifactBuilder builder) {
  String typeName = getTypeName(type);
  builder.registerDef("\$AT<$typeName>");
  String ctor = "${builder.applyDefsF("\$AT<$typeName>")}";

  if (type is InterfaceType && type.typeArguments.isNotEmpty) {
    List<String> typeArguments = <String>[];
    for (DartType arg in type.typeArguments) {
      typeArguments.add(typeDescriptorCode(arg, builder));
    }

    return "$ctor([${typeArguments.join(",")}])";
  }

  return "$ctor()";
}
