import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:toxic/extensions/iterable.dart';

class $ArtifactSchemaComponent implements $ArtifactBuilderOutput {
  const $ArtifactSchemaComponent();

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
    if (params.isEmpty) return (<Uri>[], StringBuffer());
    StringBuffer buf = StringBuffer();

    buf.write("  static Map<String, dynamic> get schema=>{");
    buf.write("${builder.stringD("type")}:${builder.stringD("object")},");
    buf.write("${builder.stringD("properties")}:{");
    for (ParameterElement i in params) {
      buf.write("${builder.stringD(i.name)}:{");

      if (i.type.getDisplayString(withNullability: true) == "String") {
        buf.write("${builder.stringD("type")}:");
        buf.write("${builder.stringD("string")},");
      } else if (i.type.getDisplayString(withNullability: true) == "int") {
        buf.write("${builder.stringD("type")}:");
        buf.write("${builder.stringD("integer")},");
      } else if (i.type.getDisplayString(withNullability: true) == "double") {
        buf.write("${builder.stringD("type")}:");
        buf.write("${builder.stringD("number")},");
      } else if (i.type.getDisplayString(withNullability: true) == "bool") {
        buf.write("${builder.stringD("type")}:");
        buf.write("${builder.stringD("boolean")},");
      } else if (i.type
          .getDisplayString(withNullability: true)
          .startsWith("List<")) {
        buf.write("${builder.stringD("type")}:");
        buf.write("${builder.stringD("array")},");
        buf.write("${builder.stringD("items")}:{");

        String tt = (i.type as InterfaceType).typeArguments[0].getDisplayString(
          withNullability: true,
        );

        if (tt == "String") {
          buf.write("${builder.stringD("type")}:");
          buf.write("${builder.stringD("string")},");
        } else if (tt == "int") {
          buf.write("${builder.stringD("type")}:");
          buf.write("${builder.stringD("integer")},");
        } else if (tt == "double") {
          buf.write("${builder.stringD("type")}:");
          buf.write("${builder.stringD("number")},");
        } else if (tt == "bool") {
          buf.write("${builder.stringD("type")}:");
          buf.write("${builder.stringD("boolean")},");
        } else {
          buf.write("...\$$tt.schema,");
        }

        buf.write("},");
      } else {
        buf.write("...\$${i.type.name}.schema,");
      }

      FieldElement? f = clazz.fields.select((j) => j.name == i.name);
      String? description =
          f == null
              ? null
              : ArtifactBuilder.$describeChecker
                  .firstAnnotationOf(f)
                  ?.getField("description")
                  ?.toStringValue();

      if (description != null) {
        buf.write(
          "${builder.stringD("description")}:${builder.stringD(description)},",
        );
      }

      buf.write("},");
    }
    buf.write("},");
    buf.write(
      "${builder.stringD("required")}:[${params.map((i) => builder.stringD(i.name)).join(",")}],",
    );
    buf.write("${builder.stringD("additionalProperties")}:_F");

    buf.writeln("};");

    return (<Uri>[], buf);
  }
}
