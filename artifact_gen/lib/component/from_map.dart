import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';

class $ArtifactFromMapComponent with $ArtifactBuilderOutput {
  const $ArtifactFromMapComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement ctor,
    List<FormalParameterElement> params,
    BuildStep step,
    List<String>? eFields,
  ) async {
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;

    builder.registerDef("ArtifactModelImporter<${clazz.name ?? ""}>");
    buf.writeln(
      "  static ${builder.applyDefsF("ArtifactModelImporter<${clazz.name ?? ""}>")} get from=>${builder.applyDefsF("ArtifactModelImporter<${clazz.name ?? ""}>")}(fromMap);",
    );

    buf.write(
      '  static ${builder.applyDefsF(clazz.name ?? "")} fromMap(${builder.applyDefsF("Map<String,dynamic>")} r){',
    );
    buf.write("_;");
    buf.write("${builder.applyDefsF("Map<String,dynamic>")} m=r.\$nn;");
    List<String> subs = builder.subclassesOf(clazz);
    if (subs.isNotEmpty) {
      String subclassTag = subclassTagFor(clazz);
      buf.write("if(m.\$c(${builder.stringD(subclassTag)})){");
      buf.write(
        "String _I=m[${builder.stringD(subclassTag)}] as ${builder.applyDefsF("String")};",
      );
      for (String s in subs) {
        buf.write("if(_I==${builder.stringD('$s')}){");
        buf.write('return \$$s.fromMap(m);}');
      }
      buf.write('}');
    }

    if (eFields != null) {
      buf.write(
        "m=${builder.applyDefsF("ArtifactSecurityUtil")}.s(m,\$artifactCipher);",
      );
    }

    buf.write('return ${builder.applyDefsF(clazz.name ?? "")}(');
    List<String> positionalArgs = <String>[];
    List<String> namedArgs = <String>[];

    for (FormalParameterElement param in params) {
      String name = paramName(param);
      DartType type = param.type;
      bool isRequired = builder.guardGeneration(
        clazz: clazz,
        stage: "from_map.required_check",
        param: param,
        run: () => builder.isRequiredParam(param),
      );
      String rn = builder.guardGeneration(
        clazz: clazz,
        stage: "from_map.rename",
        param: param,
        run: () => builder.renamedParamName(clazz, param),
      );

      String rawExpr = "m[${builder.stringD(rn)}]";

      ({String code, List<Uri> imports}) conv = builder.guardGeneration(
        clazz: clazz,
        stage: "from_map.convert",
        param: param,
        run:
            () => builder.converter.$convert(
              rawExpr,
              type,
              targetLib,
              $ArtifactConvertMode.fromMap,
            ),
      );
      importUris.addAll(conv.imports);

      String valueExpr;
      if (isRequired) {
        valueExpr =
            "m.\$c(${builder.stringD(rn)})?${conv.code}:throw __x(${builder.stringD(clazz.name ?? "")},${builder.stringD(name)})";
      } else {
        String defaultCode = builder.guardGeneration(
          clazz: clazz,
          stage: "from_map.default_value",
          param: param,
          run: () => builder.defaultValueForParam(param),
        );
        valueExpr =
            "m.\$c(${builder.stringD(rn)}) ? ${conv.code} : $defaultCode";
      }

      if (param.isNamed) {
        namedArgs.add('$name: $valueExpr');
      } else {
        positionalArgs.add(valueExpr);
      }
    }

    for (String a in positionalArgs) {
      buf.write('$a,');
    }
    for (String a in namedArgs) {
      buf.write('$a,');
    }
    buf.writeln(');}');
    return (importUris, buf);
  }
}
