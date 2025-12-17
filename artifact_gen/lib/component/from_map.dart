import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';
import 'package:toxic/extensions/iterable.dart';

class $ArtifactFromMapComponent implements $ArtifactBuilderOutput {
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
    List<String>? subs = ArtifactBuilder.$artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      buf.write("if(m.\$c(${builder.stringD('_subclass_${clazz.name}')})){");
      buf.write(
        "String _I=m[${builder.stringD('_subclass_${clazz.name}')}] as ${builder.applyDefsF("String")};",
      );
      for (String s in subs) {
        buf.write("if(_I==${builder.stringD('$s')}){");
        buf.write('return \$$s.fromMap(m);}');
      }
      buf.write('}');
    }

    if (eFields != null) {
      buf.write("m=${builder.applyDefsF("ArtifactCodecUtil")}.s(m);");
    }

    buf.write('return ${builder.applyDefsF(clazz.name ?? "")}(');
    List<String> positionalArgs = <String>[];
    List<String> namedArgs = <String>[];

    for (FormalParameterElement param in params) {
      String name = param.name ?? "";
      DartType type = param.type;
      bool isNullable = type.nullabilitySuffix == NullabilitySuffix.question;
      bool isRequired =
          param.isRequiredNamed ||
          param.isRequiredPositional ||
          (!isNullable && param.defaultValueCode == null);

      String? rn;
      FieldElement? field = clazz.fields.select((i) => i.name == param.name);

      if (field != null &&
          ArtifactBuilder.$renameChecker.hasAnnotationOf(
            field,
            throwOnUnresolved: false,
          )) {
        rn =
            ArtifactBuilder.$renameChecker
                .firstAnnotationOf(field, throwOnUnresolved: false)!
                .getField("newName")!
                .toStringValue();
      } else if (ArtifactBuilder.$renameChecker.hasAnnotationOf(
        param,
        throwOnUnresolved: false,
      )) {
        rn =
            ArtifactBuilder.$renameChecker
                .firstAnnotationOf(param, throwOnUnresolved: false)!
                .getField("newName")!
                .toStringValue();
      }

      String rawExpr = "m[${builder.stringD(rn ?? name)}]";

      ({String code, List<Uri> imports}) conv = builder.converter.$convert(
        rawExpr,
        type,
        targetLib,
        $ArtifactConvertMode.fromMap,
      );
      importUris.addAll(conv.imports);

      String valueExpr;
      if (isRequired) {
        valueExpr =
            "m.\$c(${builder.stringD(rn ?? name)})?${conv.code}:throw __x(${builder.stringD(clazz.name ?? "")},${builder.stringD(name)})";
      } else {
        String defaultCode =
            param.defaultValueCode == null
                ? 'null'
                : builder.valD(param.defaultValueCode.toString(), param.type);
        valueExpr =
            "m.\$c(${builder.stringD(rn ?? name)}) ? ${conv.code} : $defaultCode";
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

  bool $isEnum(InterfaceType type) =>
      type.element is EnumElement || type.element.kind == ElementKind.ENUM;
}
