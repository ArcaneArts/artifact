import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';
import 'package:toxic/extensions/string.dart';

class $ArtifactCopyWithComponent with $ArtifactBuilderOutput {
  const $ArtifactCopyWithComponent();

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
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;
    buf.write('  ${builder.applyDefsF(clazz.name ?? "")} copyWith({');

    for (FormalParameterElement param in params) {
      String name = paramName(param);
      DartType type = param.type;
      String baseType = baseTypeOf(type);
      builder.registerDef(baseType);
      String forceNullType = "${builder.applyDefsF(baseType)}?";

      buf.write('$forceNullType $name,');
      builder.registerDef("bool");
      if (supportsDeleteFlag(param)) {
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

      if (isCollectionType(baseType)) {
        buf.write(
          '${builder.applyDefsF(baseType)}? append${name.capitalize()},',
        );
        buf.write(
          '${builder.applyDefsF(baseType)}? remove${name.capitalize()},',
        );
      }

      if (isNumericType(baseType)) {
        buf.write(
          '${builder.applyDefsF(baseType)}? delta${name.capitalize()},',
        );
      }
    }
    buf.write('})'); // end of parameter list, start body

    List<String> subs = builder.subclassesOf(clazz);
    bool hasSubs = subs.isNotEmpty;
    if (hasSubs) {
      buf.write("{");
      for (String sub in subs) {
        buf.write('if (_H is ${builder.applyDefsF(sub)}){');
        buf.write('return (_H as ${builder.applyDefsF(sub)}).copyWith(');
        _writeForwardedCopyWithArgs(buf, params);
        buf.write(");");
        buf.write('}');
      }
    }

    buf.write(
      '${!hasSubs ? "=>" : "return "}${builder.applyDefsF(clazz.name ?? "")}(',
    );
    for (FormalParameterElement param in params) {
      String name = paramName(param);
      bool nullable = isNullableType(param.type);
      String bs = baseTypeOf(param.type);
      String resetDefault = builder.defaultValueForParam(param);
      if (isCollectionType(bs)) {
        resetDefault = _typedCollectionDefault(resetDefault, bs, builder);
      }

      String pref = "";
      String nd = nullable ? "??0" : "";
      if (isNumericType(bs)) {
        pref =
            "delta${name.capitalize()}!=null?($name??_H.$name$nd)+delta${name.capitalize()}:";
      }

      String o = "";

      if (supportsDeleteFlag(param) && param.hasDefaultValue) {
        o = '${pref}delete${name.capitalize()}?null:reset${name.capitalize()} ? $resetDefault:($name??_H.$name),';
      } else if (supportsDeleteFlag(param)) {
        o = '${pref}delete${name.capitalize()}?null:($name??_H.$name),';
      } else if (param.hasDefaultValue) {
        o = '${pref}reset${name.capitalize()}?$resetDefault:($name??_H.$name),';
      } else {
        o = '$pref$name??_H.$name,';
      }

      if (isCollectionType(bs)) {
        String gn = nullable ? "?" : "";

        if (param.hasDefaultValue) {
          builder.registerDef(bs);
          o = "((${o.substring(0, o.length - 1)}) as ${builder.applyDefsF(bs)}$gn)$gn.\$u(append${name.capitalize()},remove${name.capitalize()}),";
        } else {
          o = "(${o.substring(0, o.length - 1)})$gn.\$u(append${name.capitalize()},remove${name.capitalize()}),";
        }
      }

      buf.write('$name: $o');
    }

    buf.writeln(');${hasSubs ? "}" : ""}');

    return (importUris, buf);
  }

  void _writeForwardedCopyWithArgs(
    StringBuffer buf,
    List<FormalParameterElement> params,
  ) {
    for (FormalParameterElement param in params) {
      String name = paramName(param);
      String baseType = baseTypeOf(param.type);

      buf.write('$name: $name,');

      if (supportsDeleteFlag(param)) {
        buf.write('delete${name.capitalize()}:delete${name.capitalize()},');
      }

      if (param.hasDefaultValue) {
        buf.write('reset${name.capitalize()}:reset${name.capitalize()},');
      }

      if (isCollectionType(baseType)) {
        buf.write('append${name.capitalize()}:append${name.capitalize()},');
        buf.write('remove${name.capitalize()}:remove${name.capitalize()},');
      }

      if (isNumericType(baseType)) {
        buf.write('delta${name.capitalize()}:delta${name.capitalize()},');
      }
    }
  }

  String _typedCollectionDefault(
    String defaultValue,
    String baseType,
    ArtifactBuilder builder,
  ) {
    String trimmed = defaultValue.trim();
    if (baseType.startsWith("List<") && _isUntypedEmptyListLiteral(trimmed)) {
      String innerType = baseType.substring(5, baseType.length - 1).trim();
      return "const <${builder.applyDefsF(innerType)}>[]";
    }

    if (baseType.startsWith("Set<") && _isUntypedEmptySetLiteral(trimmed)) {
      String innerType = baseType.substring(4, baseType.length - 1).trim();
      return "const <${builder.applyDefsF(innerType)}>{}";
    }

    return defaultValue;
  }

  bool _isUntypedEmptyListLiteral(String value) =>
      value == "[]" || value == "const []";

  bool _isUntypedEmptySetLiteral(String value) =>
      value == "{}" || value == "const {}";
}
