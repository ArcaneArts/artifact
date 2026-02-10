import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:artifact_gen/builder.dart';
import 'package:build/build.dart';
import 'package:fast_log/fast_log.dart';

class $ArtifactReflectorComponent with $ArtifactBuilderOutput {
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
      '  ${builder.applyDefsF("ArtifactMirror")} get \$mirror{_;return ${builder.applyDefsF("ArtifactReflection")}.instanceOf(_H)!;}',
    );
    builder.registerDef("List<Object>");
    buf.write(
      "  static ${builder.applyDefsF("List<Object>")} get \$annotations {_;return[",
    );
    for (ElementAnnotation a in clazz.metadata.annotations) {
      String? src = _annotationCode(a, builder, importUris);
      if (src != null) {
        buf.write("$src,");
      }
    }
    buf.writeln("];}");

    builder.registerDef("List<\$AFld>");
    buf.write(
      '  static ${builder.applyDefsF("List<\$AFld>")} get \$fields{_;return[',
    );

    for (FormalParameterElement param in params) {
      String name = param.name ?? "";
      String fullType = getTypeName(param.type);
      String descriptor = typeDescriptorCode(param.type, builder);
      builder.registerDef(fullType);
      buf.write("\$AFld<${builder.applyDefsF(clazz.name ?? "")}, $fullType>(");
      buf.write("${builder.stringD(name)},");
      buf.write("(i)=>i.$name,");
      buf.write("(i,v)=>i.copyWith($name:v),");

      buf.write("[");
      FieldElement? field = clazz.getField(name);
      if (field != null) {
        for (ElementAnnotation a in field.metadata.annotations) {
          String? src = _annotationCode(a, builder, importUris);
          if (src != null) {
            buf.write("$src,");
          }
        }
      }
      buf.write("],");
      buf.write("$descriptor,");
      buf.write("),");
    }
    buf.writeln("];}");

    builder.registerDef("List<\$AMth>");
    builder.registerDef("MethodParameters");
    buf.write(
      '  static ${builder.applyDefsF("List<\$AMth>")} get \$methods {_;return[',
    );
    a:
    for (MethodElement method in clazz.methods) {
      if (method.isOperator ||
          method.isStatic ||
          method.isAbstract ||
          method.isExternal ||
          method.isPrivate ||
          method.isSynthetic) {
        continue;
      }

      for (FormalParameterElement i in method.formalParameters) {
        if (getTypeName(i.type) == "InvalidType") {
          warn(
            "Unable to reflect on method ${clazz.name}.${method.name} because param ${i.name}'s type is unreadable.",
          );
          continue a;
        }
      }

      String name = method.name ?? "";
      String fullType = getTypeName(method.returnType);
      String returnTypeDescriptor = typeDescriptorCode(
        method.returnType,
        builder,
      );
      builder.registerDef(fullType);
      buf.write("\$AMth<${builder.applyDefsF(clazz.name ?? "")}, $fullType>(");
      buf.write("${builder.stringD(name)},");
      buf.write("(i, p)=>i.$name(");
      int g = 0;
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => !i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        builder.registerDef(paramType);
        buf.write("p.o<${builder.applyDefsF(paramType)}>(${g++}),");
      }

      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        builder.registerDef(paramType);
        buf.write(
          "${i.name}: p.n<${builder.applyDefsF(paramType)}>(${builder.stringD(i.name ?? "")}),",
        );
      }
      buf.write("),");

      buf.write("[");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => !i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        builder.registerDef(paramType);
        buf.write("${builder.applyDefsF(paramType)},");
      }
      buf.write("],");
      buf.write("{");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        builder.registerDef(paramType);
        buf.write(
          "${builder.stringD(i.name ?? "")}: ${builder.applyDefsF(paramType)},",
        );
      }
      buf.write("},");
      buf.write("[");
      for (ElementAnnotation a in method.metadata.annotations) {
        String? src = _annotationCode(a, builder, importUris);
        if (src != null) {
          buf.write("$src,");
        }
      }
      buf.write("],");
      buf.write("$returnTypeDescriptor,");
      buf.write("[");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => !i.isNamed,
      )) {
        buf.write("${typeDescriptorCode(i.type, builder)},");
      }
      buf.write("],");
      buf.write("{");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        buf.write(
          "${builder.stringD(i.name ?? "")}: ${typeDescriptorCode(i.type, builder)},",
        );
      }
      buf.write("},");
      buf.write("),");
    }
    buf.writeln("];}");

    return (importUris, buf);
  }

  String? _annotationCode(
    ElementAnnotation annotation,
    ArtifactBuilder builder,
    List<Uri> importUris,
  ) {
    Element? element = annotation.element;
    if (element == null) {
      return null;
    }

    LibraryElement? library = element.library;
    if (library != null) {
      importUris.add(library.uri);
    }

    DartObject? value = annotation.computeConstantValue();
    if (value == null) {
      return null;
    }

    String src = dartObjectToCode(value, builder, importUris);
    if (src.startsWith("_Override()") || src.startsWith("Deprecated()")) {
      return null;
    }

    return src;
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

  String typeName = type.getDisplayString(withNullability: false);
  builder.registerDef(typeName);
  ClassElement ce = type.element as ClassElement;
  importUris.add(ce.library.uri);

  ConstructorElement? ctor = ce.unnamedConstructor;
  if (ctor == null) {
    return "${builder.applyDefsF(typeName)}()";
  }

  List<String> positionalArgs = <String>[];
  List<String> namedArgs = <String>[];

  for (FormalParameterElement param in ctor.formalParameters) {
    String? paramName = param.name;
    if (paramName == null) {
      continue;
    }

    DartObject? value = object.getField(paramName);
    if (value == null) {
      continue;
    }

    String code = dartObjectToCode(value, builder, importUris);
    if (param.isNamed) {
      namedArgs.add("$paramName: $code");
    } else {
      positionalArgs.add(code);
    }
  }

  String args = [...positionalArgs, ...namedArgs].join(",");
  return "${builder.applyDefsF(typeName)}($args)";
}
