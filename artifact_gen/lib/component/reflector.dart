import 'package:analyzer/dart/element/element.dart';
import 'package:artifact_gen/builder.dart';
import 'package:artifact_gen/util.dart';

class $ArtifactReflectorComponent implements $ArtifactBuilderOutput {
  const $ArtifactReflectorComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
  ) async {
    ConstructorElement? ctor = clazz.defaultConstructor;
    if (ctor == null) return (<Uri>[], StringBuffer());

    List<FormalParameterElement> params = <FormalParameterElement>[];
    for (FormalParameterElement p in ctor.formalParameters) {
      bool matchesField = clazz.getField(p.name ?? "") != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }

    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    builder.registerDef("List<\$AFld>");
    buf.write('  static ${builder.applyDefsF("List<\$AFld>")} get \$fields {');
    buf.write("_;");
    buf.write("return [");
    for (FormalParameterElement param in params) {
      String name = param.name ?? "";
      String type = param.type.getDisplayString(withNullability: true);
      String baseType = param.type.getDisplayString(withNullability: false);
      builder.registerDef(baseType);
      String fullType =
          type.endsWith("?")
              ? "${builder.applyDefsF(baseType)}?"
              : builder.applyDefsF(baseType);
      buf.write("\$AFld<${builder.applyDefsF(clazz.name ?? "")}, $fullType>(");
      buf.write("${builder.stringD(name)},");
      buf.write("(i)=>i.$name,");
      buf.write("(i,v)=>i.copyWith($name:v),");
      buf.write("),");
    }
    buf.write("];");
    buf.writeln('}');
    return (importUris, buf);
  }
}
