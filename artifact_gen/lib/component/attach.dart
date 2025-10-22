import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact/artifact.dart';
import 'package:artifact_gen/builder.dart';
import 'package:artifact_gen/util.dart';
import 'package:code_builder/code_builder.dart';
import 'package:source_gen/source_gen.dart';
import 'package:toxic/extensions/iterable.dart';

final DartEmitter _emitter = DartEmitter(useNullSafetySyntax: true);

class $ArtifactAttachComponent implements $ArtifactBuilderOutput {
  const $ArtifactAttachComponent();
  static final TypeChecker $attachChecker = TypeChecker.typeNamed(attach);

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
  ) async {
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];
    LibraryElement targetLib = clazz.library;
    ConstructorElement? ctor = clazz.defaultConstructor;
    if (ctor == null) return (<Uri>[], StringBuffer());

    List<FormalParameterElement> params = <FormalParameterElement>[];
    for (FormalParameterElement p in ctor.formalParameters) {
      bool matchesField = clazz.getField(p.name ?? "") != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }

    // Uri uri = builder.$getImport(type, targetLib);
    // if (uri.toString().isNotEmpty) importUris.add(uri);

    List<String> codes = [];
    for (FormalParameterElement p in params) {
      List<DartObject> a = [
        ...$attachChecker.annotationsOf(p, throwOnUnresolved: false),
      ];
      FieldElement? f = clazz.fields.select((i) => i.name == p.name);
      if (f == null) continue;
      a.addAll($attachChecker.annotationsOf(f, throwOnUnresolved: false));

      codes.addAll(
        a
            .map((i) => findField(i, "data"))
            .whereType<DartObject>()
            .map(
              (i) =>
                  "\$At<${builder.applyDefsF(i.type!.getDisplayString(withNullability: true))},${builder.applyDefsF(p.type.getDisplayString(withNullability: true))}>(${constantToCode(i, importUris)},${f.name})",
            ),
      );
    }

    if (codes.isNotEmpty) {
      buf.write(
        "  Iterable<R> getAttachments<T, R>(T t) => ${builder.applyDefsF("ArtifactCodecUtil")}.a<T,R>(t,[",
      );

      buf.write(codes.join(","));
      buf.writeln("]);");
      buf.writeln("  R? getAttachment<T,R>(T t)=>getAttachments<T,R>(t).\$f;");
    }

    codes.clear();
    List<DartObject> a = [
      ...$attachChecker.annotationsOf(clazz, throwOnUnresolved: false),
    ];
    codes.addAll(
      a
          .map((i) => findField(i, "data"))
          .whereType<DartObject>()
          .map((i) => "${constantToCode(i, importUris)}"),
    );
    if (codes.isNotEmpty) {
      buf.writeln(
        "  static const ${builder.applyDefsF("List<dynamic>")} rootAttachments = [${codes.join(",")}];",
      );
    }

    return (importUris, buf);
  }

  DartObject? findField(DartObject object, String field) {
    DartObject? current = object;
    while (current != null) {
      final value = current.getField(field);
      if (value != null) return value;
      current = current.getField('(super)');
    }
    return null;
  }

  String constantToCode(DartObject obj, List<Uri> importUris) {
    ConstantReader reader = ConstantReader(obj);

    if (reader.isNull ||
        reader.isBool ||
        reader.isString ||
        reader.isInt ||
        reader.isDouble) {
      return literal(reader.literalValue).accept(_emitter).toString();
    }

    DartType? type = obj.toTypeValue();
    if (type != null) {
      return type.getDisplayString(withNullability: false);
    }

    if (reader.isList) {
      String elems = reader.listValue
          .map((i) => constantToCode(i, importUris))
          .join(',');
      return '[$elems]';
    }
    if (reader.isSet) {
      String elems = reader.setValue
          .map((i) => constantToCode(i, importUris))
          .join(',');
      return '{$elems}';
    }
    if (reader.isMap) {
      String entries = reader.mapValue.entries
          .map(
            (e) =>
                '${constantToCode(e.key!, importUris)}: ${e.value == null ? "null" : constantToCode(e.value!, importUris)}',
          )
          .join(',');
      return '{$entries}';
    }

    return revivedLiteral(reader.revive(), importUris, dartEmitter: _emitter);
  }

  String revivedLiteral(
    Revivable r,
    List<Uri> importUris, {
    required DartEmitter dartEmitter,
  }) {
    StringBuffer buf = StringBuffer();
    String id = r.accessor.isNotEmpty ? r.accessor : r.source.fragment;
    buf.write(id);
    if (r.positionalArguments.isEmpty && r.namedArguments.isEmpty) {
      return buf.toString();
    }

    List<String> p = r.source.pathSegments.toList();
    p.removeAt(1);

    importUris.add(
      r.source.removeFragment().replace(scheme: "package", path: p.join("/")),
    );

    buf.write('(');
    buf.writeAll(
      r.positionalArguments.map((i) => constantToCode(i, importUris)),
      ', ',
    );

    if (r.namedArguments.isNotEmpty) {
      if (r.positionalArguments.isNotEmpty) buf.write(', ');
      buf.writeAll(
        r.namedArguments.entries.map(
          (e) => '${e.key}: ${constantToCode(e.value, importUris)}',
        ),
        ', ',
      );
    }

    buf.write(')');
    return buf.toString();
  }
}
