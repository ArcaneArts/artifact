import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/builder.dart';

class $ArtifactToMapComponent implements $ArtifactBuilderOutput {
  const $ArtifactToMapComponent();

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
      "  ${builder.applyDefsF("String")} toJson({bool pretty = false}) => ${builder.applyDefsF("ArtifactCodecUtil")}.j(pretty, toMap);",
    );
    buf.writeln("  ${builder.applyDefsF("Map<String, dynamic>")} toMap() {");
    buf.writeln("    _;");

    List<String>? subs = ArtifactBuilder.$artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      for (String sub in subs) {
        buf.writeln('    if (_t is ${builder.applyDefsF(sub)}) {');
        buf.writeln('      return (_t as ${builder.applyDefsF(sub)}).toMap();');
        buf.writeln('    }');
      }
    }

    buf.writeln(
      '    return <${builder.applyDefsF("String")}, ${builder.applyDefsF("dynamic")}>{',
    );

    InterfaceType? supType = clazz.supertype;
    while (supType != null) {
      ClassElement sup = supType.element as ClassElement;
      if (ArtifactBuilder.$artifactChecker.hasAnnotationOf(
        sup,
        throwOnUnresolved: false,
      )) {
        buf.writeln(
          "      ${builder.stringD('_subclass_${sup.name}')}: '${clazz.name}',",
        );
      }
      supType = supType.element.supertype;
    }

    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;

      ({String code, List<Uri> imports}) conv = builder.$convert(
        name,
        type,
        targetLib,
        $ArtifactConvertMode.toMap,
      );

      buf.writeln("      ${builder.stringD(name)}: ${conv.code},");
      importUris.addAll(conv.imports);
    }

    buf.writeln('    };');
    buf.writeln('  }');

    return (importUris, buf);
  }
}
