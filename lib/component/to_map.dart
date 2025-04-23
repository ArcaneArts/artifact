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

    // always generate the map – even if only the subclass keys go in it
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;
    buf.writeln(builder.applyDefs('  Map<String, dynamic> toMap() => {'));

    InterfaceType? supType = clazz.supertype;
    while (supType != null) {
      ClassElement sup = supType.element as ClassElement;
      if (ArtifactBuilder.$artifactChecker.hasAnnotationOf(
        sup,
        throwOnUnresolved: false,
      )) {
        buf.writeln(
          "    '_subclass_${sup.name}': '${clazz.name}',",
        ); // e.g. _subclass_Animal
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

      buf.writeln("    '$name': ${conv.code},");
      importUris.addAll(conv.imports);
    }

    buf.writeln('  };');
    return (importUris, buf);
  }
}
