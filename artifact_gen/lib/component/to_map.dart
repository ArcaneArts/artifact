import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';

class $ArtifactToMapComponent with $ArtifactBuilderOutput {
  const $ArtifactToMapComponent();

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

    buf.writeln(
      "  ${builder.applyDefsF("ArtifactModelExporter")} get to=>${builder.applyDefsF("ArtifactModelExporter")}(toMap);",
    );

    buf.write("  ${builder.applyDefsF("Map<String,dynamic>")} toMap(){");
    buf.write("_;");

    List<String> subs = builder.subclassesOf(clazz);
    if (subs.isNotEmpty) {
      for (String sub in subs) {
        buf.write('if (_H is ${builder.applyDefsF(sub)}){');
        buf.write('return (_H as ${builder.applyDefsF(sub)}).toMap();');
        buf.write('}');
      }
    }

    buf.write("return");

    if (eFields != null) {
      buf.write(" ${builder.applyDefsF("ArtifactCodecUtil")}.q(");
    }

    buf.write(
      '<${builder.applyDefsF("String")},${builder.applyDefsF("dynamic")}>{',
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
      String name = paramName(param);

      ({String code, List<Uri> imports}) conv = builder.converter.$convert(
        name,
        param.type,
        targetLib,
        $ArtifactConvertMode.toMap,
      );

      String rn = builder.renamedParamName(clazz, param);

      buf.write("${builder.stringD(rn)}:${conv.code.trim()},");
      importUris.addAll(conv.imports);
    }

    buf.write('}.\$nn');

    if (eFields != null) {
      buf.write(",[${eFields.map((i) => builder.stringD(i)).join(",")}]);");
    } else {
      buf.write(';');
    }

    buf.writeln('}');

    return (importUris, buf);
  }
}
