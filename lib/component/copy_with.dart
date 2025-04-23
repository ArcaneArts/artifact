import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/builder.dart';
import 'package:toxic/extensions/string.dart';

class $ArtifactCopyWithComponent implements $ArtifactBuilderOutput {
  const $ArtifactCopyWithComponent();

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

    // inside generateCopyWith, replace the parameter‑gathering loop
    List<ParameterElement> params = <ParameterElement>[];
    for (ParameterElement p in ctor.parameters) {
      bool matchesField = clazz.getField(p.name) != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }
    if (params.isEmpty) return (<Uri>[], StringBuffer());

    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;

    StringBuffer withs = StringBuffer();

    buf.writeln('  ${clazz.name} copyWith({');

    for (ParameterElement param in params) {
      String name = param.name;
      InterfaceType type = param.type as InterfaceType;

      String typeCode;
      String bs;
      String bsn;
      {
        String base = builder.applyDefsF(
          type.getDisplayString(withNullability: true),
        );
        bs = type.getDisplayString(withNullability: false);
        bsn = type.getDisplayString(withNullability: true);
        typeCode = base.endsWith('?') ? base : '$base?';
      }

      buf.writeln('    $typeCode $name,');

      if (param.isOptionalNamed && bsn.endsWith("?")) {
        buf.writeln('    bool delete${name.capitalize()} = false,');
      }

      if (param.hasDefaultValue) {
        buf.writeln('    bool reset${name.capitalize()} = false,');
      }

      Uri uri = builder.$getImport(type, targetLib);
      if (uri.toString().isNotEmpty) importUris.add(uri);

      withs.writeln(
        '  ${clazz.name} with${name.capitalize()}(${builder.applyDefsF(bs)} v) => copyWith(${param.name}:v);',
      );

      if (param.isOptionalNamed && bsn.endsWith("?")) {
        withs.writeln(
          '  ${clazz.name} delete${name.capitalize()}() => copyWith(delete${name.capitalize()}: true);',
        );
      }

      if (param.hasDefaultValue) {
        withs.writeln(
          '  ${clazz.name} reset${name.capitalize()}() => copyWith(reset${name.capitalize()}: true);',
        );
      }

      if (bs == "int") {
        withs.writeln(
          '  ${clazz.name} increment${name.capitalize()}(${builder.applyDefsF("int")} v) => copyWith(${param.name}:${bsn.endsWith("?") ? "($name??0)+v)" : "$name+v"});',
        );
        withs.writeln(
          '  ${clazz.name} decrement${name.capitalize()}(${builder.applyDefsF("int")} v) => copyWith(${param.name}:${bsn.endsWith("?") ? "($name??0)-v)" : "$name-v"});',
        );
      }
      if (bs == "double") {
        withs.writeln(
          '  ${clazz.name} increment${name.capitalize()}(${builder.applyDefsF("double")} v) => copyWith(${param.name}:${bsn.endsWith("?") ? "($name??0)+v)" : "$name+v"});',
        );
        withs.writeln(
          '  ${clazz.name} decrement${name.capitalize()}(${builder.applyDefsF("double")} v) => copyWith(${param.name}:${bsn.endsWith("?") ? "($name??0)-v)" : "$name-v"});',
        );
      }
    }
    buf.writeln('  }) '); // end of parameter list, start body

    buf.writeln('    => ${clazz.name}(');
    for (ParameterElement param in params) {
      String name = param.name;
      String j = "";
      String bsn = param.type.getDisplayString(withNullability: true);
      ;

      if (param.isOptionalNamed && bsn.endsWith("?") && param.hasDefaultValue) {
        buf.writeln(
          '      $name: delete${name.capitalize()} ? null : reset${name.capitalize()} ? ${param.defaultValueCode} : ($name ?? _t.$name),',
        );
      } else if (param.isOptionalNamed && bsn.endsWith("?")) {
        buf.writeln(
          '      $name: delete${name.capitalize()} ? null : ($name ?? _t.$name),',
        );
      } else if (param.hasDefaultValue) {
        buf.writeln(
          '      $name: reset${name.capitalize()} ? ${param.defaultValueCode} : ($name ?? _t.$name),',
        );
      } else {
        buf.writeln('      $name: $name ?? _t.$name,');
      }
    }
    buf.writeln('    );');
    buf.writeln(withs);

    return (importUris, buf);
  }
}
