import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:artifact_gen/component/component_helpers.dart';
import 'package:build/build.dart';

class $ArtifactSchemaComponent with $ArtifactBuilderOutput {
  const $ArtifactSchemaComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement ctor,
    List<FormalParameterElement> params,
    BuildStep step,
    List<String>? eFields,
  ) async {
    if (params.isEmpty) return (<Uri>[], StringBuffer());
    StringBuffer buf = StringBuffer();
    buf.write("  static Map<String,dynamic> get schema=>{");
    buf.write("${builder.stringD("type")}:${builder.stringD("object")},");
    buf.write("${builder.stringD("properties")}:{");

    for (FormalParameterElement param in params) {
      String renamed = builder.guardGeneration(
        clazz: clazz,
        stage: "schema.rename",
        param: param,
        run:
            () => builder.renamedParamName(
              clazz,
              param,
              includeParamAnnotation: false,
            ),
      );

      FieldElement? field = builder.fieldForParam(clazz, param);
      String? description =
          field == null
              ? null
              : ArtifactBuilder.$describeChecker
                  .firstAnnotationOf(field)
                  ?.getField("description")
                  ?.toStringValue();

      String schemaLiteral = builder.guardGeneration(
        clazz: clazz,
        stage: "schema.property_literal",
        param: param,
        run: () => _schemaLiteralForType(builder, param.type),
      );

      buf.write(
        "${builder.stringD(renamed)}:${_withOptionalDescription(builder, schemaLiteral, description)},",
      );
    }

    buf.write("},");

    List<FormalParameterElement> requiredParams =
        params.where(builder.isRequiredParam).toList();
    buf.write(
      "${builder.stringD("required")}:[${requiredParams.map((param) {
        String rn = builder.guardGeneration(clazz: clazz, stage: "schema.required.rename", param: param, run: () => builder.renamedParamName(clazz, param, includeParamAnnotation: false));
        return builder.stringD(rn);
      }).join(",")}],",
    );

    buf.write("${builder.stringD("additionalProperties")}:_F");
    buf.writeln("};");

    return (<Uri>[], buf);
  }

  String _withOptionalDescription(
    ArtifactBuilder builder,
    String schemaLiteral,
    String? description,
  ) {
    if (description == null || !schemaLiteral.endsWith("}")) {
      return schemaLiteral;
    }

    String prefix = schemaLiteral.substring(0, schemaLiteral.length - 1);
    return "${prefix}${builder.stringD("description")}:${builder.stringD(description)},}";
  }

  String _schemaLiteralForType(ArtifactBuilder builder, DartType type) {
    String baseType = baseTypeOf(type);
    String? primitiveType = _primitiveJsonType(baseType);

    if (primitiveType != null) {
      return "{${builder.stringD("type")}:${builder.stringD(primitiveType)},}";
    }

    if (type is InterfaceType) {
      if (builder.$isEnum(type)) {
        List<String> enumValues = _enumValues(type);
        String enumSection =
            enumValues.isEmpty
                ? ""
                : "${builder.stringD("enum")}:[${enumValues.map(builder.stringD).join(",")}],";
        return "{${builder.stringD("type")}:${builder.stringD("string")},$enumSection}";
      }

      String typeName = type.element.name ?? "";
      if ((typeName == "List" || typeName == "Set") &&
          type.typeArguments.length == 1) {
        String itemsLiteral = _schemaLiteralForType(
          builder,
          type.typeArguments[0],
        );
        String unique =
            typeName == "Set" ? "${builder.stringD("uniqueItems")}:_T," : "";
        return "{${builder.stringD("type")}:${builder.stringD("array")},${builder.stringD("items")}:$itemsLiteral,$unique}";
      }

      if (typeName == "Map" && type.typeArguments.length == 2) {
        String valueSchema = _schemaLiteralForType(
          builder,
          type.typeArguments[1],
        );
        return "{${builder.stringD("type")}:${builder.stringD("object")},${builder.stringD("additionalProperties")}:$valueSchema,}";
      }

      if (builder.$isArtifactInterface(type)) {
        return "{...\$${type.element.name}.schema,}";
      }
    }

    return "{${builder.stringD("type")}:${builder.stringD("object")},}";
  }

  List<String> _enumValues(InterfaceType type) {
    if (type.element is! EnumElement) {
      return <String>[];
    }

    EnumElement e = type.element as EnumElement;
    return e.fields
        .where((field) => field.isEnumConstant)
        .map((f) => f.name)
        .whereType<String>()
        .toList();
  }

  String? _primitiveJsonType(String typeName) {
    switch (typeName) {
      case "String":
        return "string";
      case "int":
        return "integer";
      case "double":
        return "number";
      case "bool":
        return "boolean";
      default:
        return null;
    }
  }
}
