import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';

class ArtifactTypeConverter {
  final ArtifactBuilder builder;

  ArtifactTypeConverter(this.builder);

  ({String code, List<Uri> imports}) $convert(
    String expr,
    DartType pType,
    LibraryElement targetLib,
    $ArtifactConvertMode mode,
  ) {
    if (pType is! InterfaceType) {
      if (mode == $ArtifactConvertMode.toMap) {
        return (code: expr, imports: []);
      } else {
        return (code: expr, imports: []);
      }
    }

    InterfaceType type = pType;

    List<Uri> imports = <Uri>[];

    void _addImport(DartType t) {
      if (t is InterfaceType) {
        Uri uri = builder.$getImport(t, targetLib);
        if (uri.toString().isNotEmpty) imports.add(uri);
      }
    }

    bool nullable = type.nullabilitySuffix == NullabilitySuffix.question;
    String nullOp = nullable ? '?' : '';

    if (builder.$isArtifactInterface(type)) {
      _addImport(type);
      if (mode == $ArtifactConvertMode.toMap) {
        return (
          code: builder.applyDefs(' $expr$nullOp.toMap()'),
          imports: imports,
        );
      } else {
        String name = type.element.name;
        return (
          code:
              '\$${name}.fromMap(($expr) as ${builder.applyDefsF("Map<String, dynamic>")})',
          imports: imports,
        );
      }
    }

    if (builder.$isEnum(type)) {
      _addImport(type);
      if (mode == $ArtifactConvertMode.toMap) {
        return (
          code: builder.applyDefs(' $expr$nullOp.name'),
          imports: imports,
        );
      } else {
        String name = type.element.name;
        return (
          code:
              '${builder.applyDefsF("ArtifactCodecUtil")}.e(${builder.applyDefsF(name)}.values, $expr) as ${builder.applyDefsF(name)}${nullable ? '?' : ''}',
          imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
        );
      }
    }

    String elementName = type.element.name;
    if ((elementName == 'List' || elementName == 'Set') &&
        type.typeArguments.length == 1) {
      DartType inner = type.typeArguments.first;
      _addImport(inner);
      ({String code, List<Uri> imports}) conv = $convert(
        'e',
        inner,
        targetLib,
        mode,
      ); // recurse
      String fn = elementName == 'List' ? 'toList()' : 'toSet()';
      if (mode == $ArtifactConvertMode.toMap) {
        return (
          code: builder.applyDefs(
            ' $expr$nullOp.map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      } else {
        builder.registerDef(elementName);
        return (
          code: builder.applyDefs(
            ' ($expr as ${builder.applyDefsF(elementName)}).map((e) => ${conv.code}).$fn${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      }
    }

    if (elementName == 'Map' && type.typeArguments.length == 2) {
      DartType valueT = type.typeArguments[1];
      _addImport(valueT);
      ({String code, List<Uri> imports}) conv = $convert(
        mode == $ArtifactConvertMode.fromMap ? 'e.value' : 'v',
        valueT,
        targetLib,
        mode,
      );

      String ft =
          "MapEntry<${type.typeArguments[0].getDisplayString(withNullability: true)}, ${type.typeArguments[1].getDisplayString(withNullability: true)}>";
      builder.registerDef(ft);
      ft = builder.applyDefsF(ft);

      if (mode == $ArtifactConvertMode.toMap) {
        return (
          code: builder.applyDefs(
            ' $expr$nullOp.map((k, v) => ${builder.applyDefsF("MapEntry")}(k, ${conv.code}))${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      } else {
        builder.registerDef("MapEntry");
        return (
          code: builder.applyDefs(
            ' Map.fromEntries(($expr as ${builder.applyDefsF("Map")}).\$e.\$m((e) => $ft(e.key, ${conv.code})))${nullable ? '' : ''}',
          ),
          imports: [...imports, ...conv.imports],
        );
      }
    }

    if (mode == $ArtifactConvertMode.toMap) {
      return (
        code: builder.applyDefs(' ArtifactCodecUtil.ea($expr)'),
        imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
      );
    } else {
      builder.registerDef(type.element.name);
      return (
        code: builder.applyDefs(
          ' ArtifactCodecUtil.da($expr, ${builder.applyDefsF(type.element.name)}) as ${builder.applyDefsF(type.element.name)}${nullable ? '?' : ''}',
        ),
        imports: [...imports, Uri.parse('package:artifact/artifact.dart')],
      );
    }
  }
}
