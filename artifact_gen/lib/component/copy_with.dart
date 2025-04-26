import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
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

    buf.write('  ${builder.applyDefsF(clazz.name)} copyWith({');

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

      buf.write('$forceNullType $name,');
      builder.registerDef("bool");
      if (param.isOptionalNamed && fullType.endsWith("?")) {
        buf.write(
          '${builder.applyDefsF("bool")} delete${name.capitalize()}=_F,',
        );
      }

      if (param.hasDefaultValue) {
        buf.write(
          '${builder.applyDefsF("bool")} reset${name.capitalize()}=_F,',
        );
      }

      Uri uri = builder.$getImport(type, targetLib);
      if (uri.toString().isNotEmpty) importUris.add(uri);

      if (baseType.startsWith("List<") || baseType.startsWith("Set<")) {
        buf.write(
          '${builder.applyDefsF(baseType)}? append${name.capitalize()},',
        );
        buf.write(
          '${builder.applyDefsF(baseType)}? remove${name.capitalize()},',
        );
      }

      if (baseType == "int") {
        buf.write('${builder.applyDefsF("int")}? delta${name.capitalize()},');
      }
      if (baseType == "double") {
        buf.write(
          '${builder.applyDefsF("double")}? delta${name.capitalize()},',
        );
      }
    }
    buf.write('})'); // end of parameter list, start body

    buf.write('=>${builder.applyDefsF(clazz.name)}(');
    for (ParameterElement param in params) {
      String name = param.name;
      String bsn = param.type.getDisplayString(withNullability: true);

      String pref = "";
      String nd = bsn.endsWith("?") ? "??0" : "";
      String bs = param.type.getDisplayString(withNullability: false);
      if (bs == "int") {
        pref =
            "delta${name.capitalize()}!=null?($name??_H.$name$nd)+delta${name.capitalize()}:";
      }

      if (bs == "double") {
        pref =
            "delta${name.capitalize()}!=null?($name??_H.$name$nd)+delta${name.capitalize()}:";
      }

      String o = "";

      if (param.isOptionalNamed && bsn.endsWith("?") && param.hasDefaultValue) {
        o = '${pref}delete${name.capitalize()}?null:reset${name.capitalize()} ? ${builder.valD(param.defaultValueCode.toString(), param.type)}:($name??_H.$name),';
      } else if (param.isOptionalNamed && bsn.endsWith("?")) {
        o = '${pref}delete${name.capitalize()}?null:($name??_H.$name),';
      } else if (param.hasDefaultValue) {
        o = '${pref}reset${name.capitalize()}?${builder.valD(param.defaultValueCode.toString(), param.type)}:($name??_H.$name),';
      } else {
        o = '$pref$name??_H.$name,';
      }

      if (bs.startsWith("List<") || bs.startsWith("Set<")) {
        String gn = "";

        if (param.type.getDisplayString(withNullability: true).endsWith("?")) {
          gn = "?";
        }

        o = "(${o.substring(0, o.length - 1)})$gn.\$u(append${name.capitalize()},remove${name.capitalize()}),";
      }

      buf.write('$name: $o');
    }

    buf.writeln(');');

    return (importUris, buf);
  }
}
