import 'package:analyzer/dart/element/element.dart';
import 'package:artifact_gen/builder.dart';

extension ArtifactComponentBuilderHelpers on ArtifactBuilder {
  FieldElement? fieldForParam(
    ClassElement clazz,
    FormalParameterElement param,
  ) {
    if (param.name == null) {
      return null;
    }

    return clazz.getField(param.name!);
  }

  String renamedParamName(
    ClassElement clazz,
    FormalParameterElement param, {
    bool includeParamAnnotation = true,
  }) {
    String fallback = param.name ?? "";
    FieldElement? field = fieldForParam(clazz, param);
    String? renamed;

    if (field != null &&
        ArtifactBuilder.$renameChecker.hasAnnotationOf(
          field,
          throwOnUnresolved: false,
        )) {
      renamed =
          ArtifactBuilder.$renameChecker
              .firstAnnotationOf(field, throwOnUnresolved: false)
              ?.getField("newName")
              ?.toStringValue();
    }

    if (renamed == null &&
        includeParamAnnotation &&
        ArtifactBuilder.$renameChecker.hasAnnotationOf(
          param,
          throwOnUnresolved: false,
        )) {
      renamed =
          ArtifactBuilder.$renameChecker
              .firstAnnotationOf(param, throwOnUnresolved: false)
              ?.getField("newName")
              ?.toStringValue();
    }

    return renamed ?? fallback;
  }

  bool isRequiredParam(FormalParameterElement param) {
    bool nullable = param.type
        .getDisplayString(withNullability: true)
        .endsWith("?");

    return param.isRequiredNamed ||
        param.isRequiredPositional ||
        (!nullable && param.defaultValueCode == null);
  }

  String defaultValueForParam(
    FormalParameterElement param, {
    String fallback = "null",
  }) {
    if (param.defaultValueCode == null) {
      return fallback;
    }

    return valD(param.defaultValueCode.toString(), param.type);
  }

  List<String> subclassesOf(ClassElement clazz) {
    return List<String>.from(
      ArtifactBuilder.$artifactSubclasses[clazz.name] ?? const <String>[],
    );
  }
}
