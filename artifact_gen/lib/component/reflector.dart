import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';
import 'package:toxic/extensions/iterable.dart';

class $ArtifactReflectorComponent implements $ArtifactBuilderOutput {
  const $ArtifactReflectorComponent();

  @override
  Future<$BuildOutput> onGenerate(
    ArtifactBuilder builder,
    ClassElement clazz,
    ConstructorElement ctor,
    List<FormalParameterElement> params,
    BuildStep step,
    List<String>? eFields,
  ) async {
    StringBuffer buf = StringBuffer();
    List<Uri> importUris = <Uri>[];

    buf.writeln(
      '  ${builder.applyDefsF("ArtifactMirror")} get \$mirror{_;return ${builder.applyDefsF("ArtifactCodecUtil")}.m(_H)!;}',
    );
    builder.registerDef("List<Object>");
    buf.write(
      "  static ${builder.applyDefsF("List<Object>")} get \$annotations {_;return[",
    );
    for (ElementAnnotation a in clazz.metadata.annotations) {
      importUris.add(a.element!.library!.uri);
      DartObject v = a.computeConstantValue()!;
      buf.write("${dartObjectToCode(v, builder, importUris)},");
    }
    buf.writeln("];}");

    builder.registerDef("List<\$AFld>");
    buf.write(
      '  static ${builder.applyDefsF("List<\$AFld>")} get \$fields{_;return[',
    );

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

      buf.write("[");
      FieldElement? field = clazz.getField(name);
      if (field != null) {
        for (ElementAnnotation a in field.metadata.annotations) {
          importUris.add(a.element!.library!.uri);
          DartObject v = a.computeConstantValue()!;
          String src = dartObjectToCode(v, builder, importUris);

          if (src.startsWith("_") || src.startsWith("Deprecated()")) {
            continue;
          }

          buf.write("$src,");
        }
      }
      buf.write("],");
      buf.write("),");
    }
    buf.writeln("];}");

    builder.registerDef("List<\$AMth>");
    builder.registerDef("MethodParameters");
    buf.write(
      '  static ${builder.applyDefsF("List<\$AMth>")} get \$methods {_;return[',
    );
    for (MethodElement method in clazz.methods) {
      if (method.isOperator ||
          method.isStatic ||
          method.isAbstract ||
          method.isExternal ||
          method.isPrivate ||
          method.isSynthetic) {
        continue;
      }

      String name = method.name ?? "";
      String type = method.returnType.getDisplayString(withNullability: true);
      String baseType = method.returnType.getDisplayString(
        withNullability: false,
      );
      builder.registerDef(baseType);
      String fullType =
          type.endsWith("?")
              ? "${builder.applyDefsF(baseType)}?"
              : builder.applyDefsF(baseType);
      buf.write("\$AMth<${builder.applyDefsF(clazz.name ?? "")}, $fullType>(");
      buf.write("${builder.stringD(name)},");
      buf.write("(i, p)=>i.$name(");
      int g = 0;
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => !i.isNamed,
      )) {
        buf.write(
          "p.o<${builder.applyDefsF(i.type.getDisplayString(withNullability: false))}>(${g++}),",
        );
      }

      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        buf.write(
          "${i.name}: p.n<${builder.applyDefsF(i.type.getDisplayString(withNullability: false))}>(${builder.stringD(i.name ?? "")}),",
        );
      }
      buf.write("),");

      buf.write("[");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => !i.isNamed,
      )) {
        builder.registerDef(i.type.getDisplayString(withNullability: false));
        buf.write(
          "${builder.applyDefsF(i.type.getDisplayString(withNullability: false))},",
        );
      }
      buf.write("],");
      buf.write("{");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        builder.registerDef(i.type.getDisplayString(withNullability: false));
        buf.write(
          "${builder.stringD(i.name ?? "")}: ${builder.applyDefsF(i.type.getDisplayString(withNullability: false))},",
        );
      }
      buf.write("},");
      buf.write("[");
      for (ElementAnnotation a in method.metadata.annotations) {
        importUris.add(a.element!.library!.uri);
        DartObject v = a.computeConstantValue()!;
        String src = dartObjectToCode(v, builder, importUris);

        if (src.startsWith("_") || src.startsWith("Deprecated()")) {
          continue;
        }

        buf.write("$src,");
      }
      buf.write("],");
      buf.write("),");
    }
    buf.writeln("];}");

    return (importUris, buf);
  }
}

String dartObjectToCode(
  DartObject object,
  ArtifactBuilder builder,
  List<Uri> importUris,
) {
  if (object.isNull) {
    return "null";
  }

  DartType type = object.type!;

  if (type.isDartCoreEnum || type.element is EnumElement) {
    String enumName = type.getDisplayString(withNullability: false);
    builder.registerDef(enumName);
    String enumValue =
        object.variable?.toString().split(" ").last.trim() ?? "ERROR";
    importUris.add(type.element!.library!.uri);
    return "${builder.applyDefsF(enumName)}.$enumValue";
  }

  if (type.isDartCoreSet) {
    List<DartObject> elements = object.toSetValue()!.toList();
    String elementType = (type as InterfaceType).typeArguments[0]
        .getDisplayString(withNullability: false);
    return "<$elementType>{${elements.map((v) => dartObjectToCode(v, builder, importUris)).join(",")}}";
  }

  if (type.isDartCoreList || type.isDartCoreIterable) {
    List<DartObject> elements = object.toListValue()!;
    String elementType = (type as InterfaceType).typeArguments[0]
        .getDisplayString(withNullability: false);
    return "<$elementType>[${elements.map((v) => dartObjectToCode(v, builder, importUris)).join(",")}]";
  }

  if (type.isDartCoreBool) {
    return object.toBoolValue()! ? "_T" : "_F";
  }

  if (type.isDartCoreInt) {
    return object.toIntValue()!.toString();
  }

  if (type.isDartCoreDouble) {
    return object.toDoubleValue()!.toString();
  }

  if (type.isDartCoreString) {
    return "${builder.stringD(object.toStringValue()!.replaceAll("'", "\\'"))}";
  }

  if (type.isDartCoreNum) {
    return object.toDoubleValue()!.toString();
  }

  if (type.isDartCoreMap) {
    Map<DartObject?, DartObject?> map = object.toMapValue()!;
    String keyType = (type as InterfaceType).typeArguments[0].getDisplayString(
      withNullability: false,
    );
    String valueType = type.typeArguments[1].getDisplayString(
      withNullability: false,
    );
    return "<$keyType, $valueType>{${map.entries.where((e) => e.key != null).map((e) => "${dartObjectToCode(e.key!, builder, importUris)}: ${e.value == null ? "null" : dartObjectToCode(e.value!, builder, importUris)}").join(",")}}";
  }

  if (type.isDartCoreType) {
    DartType? dt = object.toTypeValue();
    return dt != null ? dt.getDisplayString(withNullability: false) : "dynamic";
  }

  StringBuffer sb = StringBuffer();
  builder.registerDef(type.getDisplayString(withNullability: false));
  sb.write(
    "${builder.applyDefsF(type.getDisplayString(withNullability: false))}(",
  );
  ClassElement ce = type.element as ClassElement;
  importUris.add(ce.library.uri);
  List<FormalParameterElement> pars =
      ce.unnamedConstructor!.formalParameters.where((i) => i.isNamed).toList();
  for (FieldElement i in ce.fields.where((f) => !f.isStatic && f.isFinal)) {
    DartObject? v = object.getField(i.name ?? "");
    if (v != null) {
      FormalParameterElement? fpe = pars.select((p) => p.name == i.name);

      if (fpe != null) {
        sb.write("${i.name}: ${dartObjectToCode(v, builder, importUris)},");
      }
    }
  }

  sb.write(")");

  return sb.toString();
}
