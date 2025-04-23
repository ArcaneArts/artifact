import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/builder.dart';

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

    buf.writeln('  static ${clazz.name} fromMap(Map<String, dynamic> map) {');

    List<String>? subs = ArtifactBuilder.$artifactSubclasses[clazz.name];
    if (subs != null && subs.isNotEmpty) {
      buf.writeln("    if (map.\$c('_subclass_${clazz.name}')) {");
      buf.writeln(
        "      String sub = map['_subclass_${clazz.name}'] as String;",
      );
      buf.writeln('      switch (sub) {');
      for (String s in subs) {
        buf.writeln("        case '$s':");
        buf.writeln('          return \$$s.fromMap(map);');
      }
      buf.writeln('      }');
      buf.writeln('    }');
    }

    buf.writeln('    return ${clazz.name}(');

    List<String> positionalArgs = <String>[];
    List<String> namedArgs = <String>[];

    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;
      bool isNullable = type.nullabilitySuffix == NullabilitySuffix.question;
      bool isRequired =
          param.isRequiredNamed ||
          param.isRequiredPositional ||
          (!isNullable && param.defaultValueCode == null);
      String rawExpr = "map['$name']";

      ({String code, List<Uri> imports}) conv = builder.$convert(
        rawExpr,
        type,
        targetLib,
        $ArtifactConvertMode.fromMap,
      );
      importUris.addAll(conv.imports);

      String valueExpr;
      if (isRequired) {
        valueExpr =
            "map.\$c('$name') ? ${conv.code} : (throw ArgumentError('Missing required ${clazz.name}.\"$name\" in map \$map.'))";
      } else {
        String defaultCode = param.defaultValueCode ?? 'null';
        valueExpr = "map.\$c('$name') ? ${conv.code} : $defaultCode";
      }

      if (param.isNamed) {
        namedArgs.add('$name: $valueExpr');
      } else {
        positionalArgs.add(valueExpr);
      }
    }

    for (String a in positionalArgs) {
      buf.writeln('      $a,');
    }
    for (String a in namedArgs) {
      buf.writeln('      $a,');
    }

    buf.writeln('    );');
    buf.writeln('  }');
    return (importUris, buf);
  }
}
