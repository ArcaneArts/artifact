import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:toxic/extensions/iterable.dart';

class $ArtifactToMapComponent implements $ArtifactBuilderOutput {
  const $ArtifactToMapComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement ctor,
    List<FormalParameterElement> params,
  ) async {
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;
    buf.writeln(
      "  ${builder.applyDefsF("String")} toJson({bool pretty=_F})=>${builder.applyDefsF("ArtifactCodecUtil")}.j(pretty, toMap);",
    );
    buf.writeln(
      "  ${builder.applyDefsF("String")} toYaml()=>${builder.applyDefsF("ArtifactCodecUtil")}.y(toMap);",
    );
    buf.writeln(
      "  ${builder.applyDefsF("String")} toToml()=>${builder.applyDefsF("ArtifactCodecUtil")}.u(toMap);",
    );
    buf.writeln(
      "  ${builder.applyDefsF("String")} toXml({bool pretty=_F})=>${builder.applyDefsF("ArtifactCodecUtil")}.z(pretty,toMap);",
    );
    buf.writeln(
      "  ${builder.applyDefsF("String")} toProperties()=>${builder.applyDefsF("ArtifactCodecUtil")}.h(toMap);",
    );
    buf.write("  ${builder.applyDefsF("Map<String, dynamic>")} toMap(){");
    buf.write("_;");

    List<String>? subs = ArtifactBuilder.$artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      for (String sub in subs) {
        buf.write('if (_H is ${builder.applyDefsF(sub)}){');
        buf.write('return (_H as ${builder.applyDefsF(sub)}).toMap();');
        buf.write('}');
      }
    }

    buf.write(
      'return <${builder.applyDefsF("String")}, ${builder.applyDefsF("dynamic")}>{',
    );

    InterfaceType? supType = clazz.supertype;
    while (supType != null) {
      ClassElement sup = supType.element as ClassElement;
      if (ArtifactBuilder.$artifactChecker.hasAnnotationOf(
        sup,
        throwOnUnresolved: false,
      )) {
        buf.write(
          "${builder.stringD('_subclass_${sup.name}')}: '${clazz.name}',",
        );
      }
      supType = supType.element.supertype;
    }

    for (FormalParameterElement param in params) {
      String name = param.name ?? "";

      ({String code, List<Uri> imports}) conv = builder.converter.$convert(
        name,
        param.type,
        targetLib,
        $ArtifactConvertMode.toMap,
      );

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

      buf.write("${builder.stringD(rn ?? name)}:${conv.code.trim()},");
      importUris.addAll(conv.imports);
    }

    buf.write('}.\$nn;');
    buf.writeln('}');

    return (importUris, buf);
  }
}
