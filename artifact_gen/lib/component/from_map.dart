import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:toxic/extensions/iterable.dart';

class $ArtifactFromMapComponent implements $ArtifactBuilderOutput {
  const $ArtifactFromMapComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
  ) async {
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

    buf.writeln(
      "  static ${builder.applyDefsF(clazz.name)} fromJson(String j)=>fromMap(${builder.applyDefsF("ArtifactCodecUtil")}.o(j));",
    );
    buf.write(
      '  static ${builder.applyDefsF(clazz.name)} fromMap(${builder.applyDefsF("Map<String, dynamic>")} m){',
    );
    buf.write("_;");
    List<String>? subs = ArtifactBuilder.$artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      buf.write("if(m.\$c(${builder.stringD('_subclass_${clazz.name}')})){");
      buf.write(
        "String sub=m[${builder.stringD('_subclass_${clazz.name}')}] as ${builder.applyDefsF("String")};",
      );
      buf.write('switch(sub){');
      for (String s in subs) {
        buf.write("case ${builder.stringD('$s')}:");
        buf.write('return \$$s.fromMap(m);');
      }
      buf.write('}');
      buf.write('}');
    }

    buf.write('return ${builder.applyDefsF(clazz.name)}(');

    List<String> positionalArgs = <String>[];
    List<String> namedArgs = <String>[];

    for (ParameterElement param in params) {
      String name = param.name;
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
        builder.registerDef("ArgumentError");
        valueExpr =
            "m.\$c(${builder.stringD('$name')})?${conv.code}:(throw ${builder.applyDefsF("ArgumentError")}('\${${builder.stringD("Missing required ${clazz.name}.\"$name\" in map ")}}\$m.'))";
      } else {
        String defaultCode =
            param.defaultValueCode == null
                ? 'null'
                : builder.valD(param.defaultValueCode.toString(), param.type);
        valueExpr =
            "m.\$c(${builder.stringD('$name')}) ? ${conv.code} : $defaultCode";
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

    buf.write(');');
    buf.writeln('}');
    return (importUris, buf);
  }
}
