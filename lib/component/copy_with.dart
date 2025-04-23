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

    buf.writeln('  ${builder.applyDefsF(clazz.name)} copyWith({');

    for (ParameterElement param in params) {
      String name = param.name;
      DartType type = param.type;
      String baseType = type.getDisplayString(withNullability: false);
      builder.registerDef(baseType);
      String fullType =
          type.getDisplayString(withNullability: true).endsWith("?")
              ? "${builder.applyDefsF(baseType)}?"
              : builder.applyDefsF(baseType);
      String forceNullType = "${builder.applyDefsF(baseType)}?";

      buf.writeln('    $forceNullType $name,');
      builder.registerDef("bool");
      if (param.isOptionalNamed && fullType.endsWith("?")) {
        buf.writeln(
          '    ${builder.applyDefsF("bool")} delete${name.capitalize()} = _F,',
        );
      }

      if (param.hasDefaultValue) {
        buf.writeln(
          '    ${builder.applyDefsF("bool")} reset${name.capitalize()} = _F,',
        );
      }

      Uri uri = builder.$getImport(type, targetLib);
      if (uri.toString().isNotEmpty) importUris.add(uri);

      if (baseType == "int") {
        buf.writeln(
          '    ${builder.applyDefsF("int")}? delta${name.capitalize()},',
        );
      }
      if (baseType == "double") {
        buf.writeln(
          '    ${builder.applyDefsF("double")}? delta${name.capitalize()},',
        );
      }
    }
    buf.writeln('  }) '); // end of parameter list, start body

    buf.writeln('    => ${clazz.name}(');
    for (ParameterElement param in params) {
      String name = param.name;
      String bsn = param.type.getDisplayString(withNullability: true);

      String pref = "";
      String nd = bsn.endsWith("?") ? " ?? 0" : "";
      String bs = param.type.getDisplayString(withNullability: false);
      if (bs == "int") {
        pref =
            "delta${name.capitalize()} != null ? ($name ?? _t.$name$nd) + delta${name.capitalize()} : ";
      }

      if (bs == "double") {
        pref =
            "delta${name.capitalize()} != null ? ($name ?? _t.$name$nd) + delta${name.capitalize()} : ";
      }

      if (param.isOptionalNamed && bsn.endsWith("?") && param.hasDefaultValue) {
        buf.writeln(
          '      $name: $pref delete${name.capitalize()} ? null : reset${name.capitalize()} ? ${param.defaultValueCode} : ($name ?? _t.$name),',
        );
      } else if (param.isOptionalNamed && bsn.endsWith("?")) {
        buf.writeln(
          '      $name: $pref delete${name.capitalize()} ? null : ($name ?? _t.$name),',
        );
      } else if (param.hasDefaultValue) {
        buf.writeln(
          '      $name: $pref reset${name.capitalize()} ? ${param.defaultValueCode} : ($name ?? _t.$name),',
        );
      } else {
        buf.writeln('      $name: $pref$name ?? _t.$name,');
      }
    }
    buf.writeln('    );');

    return (importUris, buf);
  }
}
