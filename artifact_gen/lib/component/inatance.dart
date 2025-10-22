import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';

class $ArtifactInstanceComponent implements $ArtifactBuilderOutput {
  const $ArtifactInstanceComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement ctor,
    List<FormalParameterElement> params,
  ) async {
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    buf.write(
      "  static ${builder.applyDefsF(clazz.name ?? "")} get newInstance=>${builder.applyDefsF(clazz.name ?? "")}(",
    );

    for (FormalParameterElement i in params) {
      if (i.isRequired) {
        if (i.type.nullabilitySuffix == NullabilitySuffix.question) {
          buf.write("${i.name}: null,");
        } else if (i.hasDefaultValue) {
          String defaultCode =
              i.defaultValueCode == null
                  ? 'null'
                  : builder.valD(i.defaultValueCode.toString(), i.type);
          buf.write("${i.name}: $defaultCode,");
        } else if (i.type.isDartCoreBool) {
          buf.write("${i.name}: _F,");
        } else if (i.type.isDartCoreInt || i.type.isDartCoreDouble) {
          buf.write("${i.name}: 0,");
        } else if (i.type.isDartCoreString) {
          buf.write("${i.name}: '',");
        } else if (i.type.isDartCoreIterable || i.type.isDartCoreList) {
          buf.write("${i.name}: [],");
        } else if (i.type.name == "DateTime") {
          buf.write("${i.name}: DateTime.now(),");
        } else if (i.type.isDartCoreEnum ||
            (i.type is InterfaceType && $isEnum(i.type as InterfaceType))) {
          buf.write(
            "${i.name}: ${builder.applyDefsF(i.type.getDisplayString(withNullability: false))}.values.first,",
          );
        } else if (i.type.isDartCoreSet || i.type.isDartCoreMap) {
          buf.write("${i.name}: {},");
        } else {
          buf.write(
            "${i.name}: \$${(i.type.getDisplayString(withNullability: false))}.newInstance,",
          );
        }
      }
    }

    buf.writeln(');');

    return (importUris, buf);
  }

  bool $isEnum(InterfaceType type) =>
      type.element is EnumElement || type.element.kind == ElementKind.ENUM;
}
