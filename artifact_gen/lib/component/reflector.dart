import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
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
    LibraryElement targetLib = clazz.library;

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
      _addTypeImports(param.type, targetLib, builder, importUris);
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
      _addTypeImports(method.returnType, targetLib, builder, importUris);
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
        _addTypeImports(i.type, targetLib, builder, importUris);
        builder.registerDef(paramType);
        buf.write("p.o<${builder.applyDefsF(paramType)}>(${g++}),");
      }

      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        _addTypeImports(i.type, targetLib, builder, importUris);
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
        _addTypeImports(i.type, targetLib, builder, importUris);
        builder.registerDef(paramType);
        buf.write("${builder.applyDefsF(paramType)},");
      }
      buf.write("],");
      buf.write("{");
      for (FormalParameterElement i in method.formalParameters.where(
        (i) => i.isNamed,
      )) {
        String paramType = getTypeName(i.type);
        _addTypeImports(i.type, targetLib, builder, importUris);
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

    _AnnotationSourceArgs sourceArgs = _parseAnnotationSourceArgs(annotation);
    String src = dartObjectToCode(
      value,
      builder,
      importUris,
      sourceArgs: sourceArgs,
    );
    if (src.startsWith("_Override()") || src.startsWith("Deprecated()")) {
      return null;
    }

    return src;
  }
}

void _addTypeImports(
  DartType type,
  LibraryElement targetLib,
  ArtifactBuilder builder,
  List<Uri> importUris,
) {
  if (type is InterfaceType) {
    Uri uri = builder.$getImport(type, targetLib);
    if (uri.toString().isNotEmpty) {
      importUris.add(uri);
    }

    for (DartType arg in type.typeArguments) {
      _addTypeImports(arg, targetLib, builder, importUris);
    }

    return;
  }
}

class _AnnotationSourceArgs {
  final List<String> positional;
  final Map<String, String> named;

  const _AnnotationSourceArgs({
    this.positional = const <String>[],
    this.named = const <String, String>{},
  });
}

_AnnotationSourceArgs _parseAnnotationSourceArgs(ElementAnnotation annotation) {
  try {
    dynamic rawAst = (annotation as dynamic).annotationAst;
    if (rawAst is Annotation) {
      ArgumentList? args = rawAst.arguments;
      if (args != null) {
        List<String> positional = <String>[];
        Map<String, String> named = <String, String>{};
        for (Expression argument in args.arguments) {
          if (argument is NamedExpression) {
            named[argument.name.label.name] = argument.expression.toSource();
          } else {
            positional.add(argument.toSource());
          }
        }

        return _AnnotationSourceArgs(positional: positional, named: named);
      }
    }
  } catch (_) {}

  String source = annotation.toSource().trim();
  if (source.startsWith('@')) {
    source = source.substring(1).trim();
  }

  if (!source.contains('(')) {
    return const _AnnotationSourceArgs();
  }

  CompilationUnit unit = parseString(content: "const __a = $source;").unit;
  if (unit.declarations.isEmpty) {
    return const _AnnotationSourceArgs();
  }

  AstNode firstDeclaration = unit.declarations.first;
  TopLevelVariableDeclaration? declaration =
      firstDeclaration is TopLevelVariableDeclaration ? firstDeclaration : null;
  if (declaration == null) {
    return const _AnnotationSourceArgs();
  }

  VariableDeclarationList list = declaration.variables;
  if (list.variables.isEmpty) {
    return const _AnnotationSourceArgs();
  }

  Expression? initializer = list.variables.first.initializer;
  ArgumentList? args = _argumentListOf(initializer);
  if (args == null) {
    return const _AnnotationSourceArgs();
  }

  List<String> positional = <String>[];
  Map<String, String> named = <String, String>{};
  for (Expression argument in args.arguments) {
    if (argument is NamedExpression) {
      named[argument.name.label.name] = argument.expression.toSource();
    } else {
      positional.add(argument.toSource());
    }
  }

  return _AnnotationSourceArgs(positional: positional, named: named);
}

_AnnotationSourceArgs _parseArgsFromExpression(String source) {
  try {
    CompilationUnit unit = parseString(content: "const __a = $source;").unit;
    if (unit.declarations.isEmpty) {
      return const _AnnotationSourceArgs();
    }

    AstNode firstDeclaration = unit.declarations.first;
    TopLevelVariableDeclaration? declaration =
        firstDeclaration is TopLevelVariableDeclaration
            ? firstDeclaration
            : null;
    if (declaration == null) {
      return const _AnnotationSourceArgs();
    }

    VariableDeclarationList list = declaration.variables;
    if (list.variables.isEmpty) {
      return const _AnnotationSourceArgs();
    }

    Expression? initializer = list.variables.first.initializer;
    ArgumentList? args = _argumentListOf(initializer);
    if (args == null) {
      return const _AnnotationSourceArgs();
    }

    List<String> positional = <String>[];
    Map<String, String> named = <String, String>{};
    for (Expression argument in args.arguments) {
      if (argument is NamedExpression) {
        named[argument.name.label.name] = argument.expression.toSource();
      } else {
        positional.add(argument.toSource());
      }
    }

    return _AnnotationSourceArgs(positional: positional, named: named);
  } catch (_) {
    return const _AnnotationSourceArgs();
  }
}

ArgumentList? _argumentListOf(Expression? expression) {
  if (expression == null) {
    return null;
  }

  if (expression is InstanceCreationExpression) {
    return expression.argumentList;
  }

  if (expression is MethodInvocation) {
    return expression.argumentList;
  }

  return null;
}

List<String>? _parseCollectionElementSources(String source) {
  try {
    CompilationUnit unit = parseString(content: "const __a = $source;").unit;
    if (unit.declarations.isEmpty) {
      return null;
    }

    AstNode firstDeclaration = unit.declarations.first;
    TopLevelVariableDeclaration? declaration =
        firstDeclaration is TopLevelVariableDeclaration
            ? firstDeclaration
            : null;
    if (declaration == null) {
      return null;
    }

    VariableDeclarationList list = declaration.variables;
    if (list.variables.isEmpty) {
      return null;
    }

    Expression? initializer = list.variables.first.initializer;
    if (initializer is ListLiteral) {
      List<String> out = <String>[];
      for (CollectionElement element in initializer.elements) {
        if (element is Expression) {
          out.add(element.toSource());
        }
      }
      return out;
    }

    if (initializer is SetOrMapLiteral && initializer.isMap == false) {
      List<String> out = <String>[];
      for (CollectionElement element in initializer.elements) {
        if (element is Expression) {
          out.add(element.toSource());
        }
      }
      return out;
    }
  } catch (_) {}

  return null;
}

List<MapEntry<String, String>>? _parseMapEntrySources(String source) {
  try {
    CompilationUnit unit = parseString(content: "const __a = $source;").unit;
    if (unit.declarations.isEmpty) {
      return null;
    }

    AstNode firstDeclaration = unit.declarations.first;
    TopLevelVariableDeclaration? declaration =
        firstDeclaration is TopLevelVariableDeclaration
            ? firstDeclaration
            : null;
    if (declaration == null) {
      return null;
    }

    VariableDeclarationList list = declaration.variables;
    if (list.variables.isEmpty) {
      return null;
    }

    Expression? initializer = list.variables.first.initializer;
    if (initializer is SetOrMapLiteral && initializer.isMap == true) {
      List<MapEntry<String, String>> out = <MapEntry<String, String>>[];
      for (CollectionElement element in initializer.elements) {
        if (element is MapLiteralEntry) {
          out.add(MapEntry(element.key.toSource(), element.value.toSource()));
        }
      }
      return out;
    }
  } catch (_) {}

  return null;
}

String dartObjectToCode(
  DartObject object,
  ArtifactBuilder builder,
  List<Uri> importUris, {
  _AnnotationSourceArgs? sourceArgs,
  String? sourceExpression,
}) {
  _AnnotationSourceArgs? activeSourceArgs = sourceArgs;
  if (activeSourceArgs == null && sourceExpression != null) {
    activeSourceArgs = _parseArgsFromExpression(sourceExpression);
  }

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
    List<String>? elementSources =
        sourceExpression == null
            ? null
            : _parseCollectionElementSources(sourceExpression);
    List<String> encoded = <String>[];
    for (int i = 0; i < elements.length; i++) {
      String? elementSource;
      if (elementSources != null && i < elementSources.length) {
        elementSource = elementSources[i];
      }

      encoded.add(
        dartObjectToCode(
          elements[i],
          builder,
          importUris,
          sourceExpression: elementSource,
        ),
      );
    }
    return "<$elementType>{${encoded.join(",")}}";
  }

  if (type.isDartCoreList || type.isDartCoreIterable) {
    List<DartObject> elements = object.toListValue()!;
    String elementType = (type as InterfaceType).typeArguments[0]
        .getDisplayString(withNullability: false);
    List<String>? elementSources =
        sourceExpression == null
            ? null
            : _parseCollectionElementSources(sourceExpression);
    List<String> encoded = <String>[];
    for (int i = 0; i < elements.length; i++) {
      String? elementSource;
      if (elementSources != null && i < elementSources.length) {
        elementSource = elementSources[i];
      }

      encoded.add(
        dartObjectToCode(
          elements[i],
          builder,
          importUris,
          sourceExpression: elementSource,
        ),
      );
    }
    return "<$elementType>[${encoded.join(",")}]";
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
    List<MapEntry<String, String>>? sourceEntries =
        sourceExpression == null
            ? null
            : _parseMapEntrySources(sourceExpression);
    List<String> encodedEntries = <String>[];
    int index = 0;
    for (MapEntry<DartObject?, DartObject?> entry in map.entries) {
      if (entry.key == null) {
        continue;
      }

      String? keySource;
      String? valueSource;
      if (sourceEntries != null && index < sourceEntries.length) {
        keySource = sourceEntries[index].key;
        valueSource = sourceEntries[index].value;
      }

      String keyCode = dartObjectToCode(
        entry.key!,
        builder,
        importUris,
        sourceExpression: keySource,
      );
      String valueCode =
          entry.value == null
              ? "null"
              : dartObjectToCode(
                entry.value!,
                builder,
                importUris,
                sourceExpression: valueSource,
              );
      encodedEntries.add("$keyCode: $valueCode");
      index++;
    }

    return "<$keyType, $valueType>{${encodedEntries.join(",")}}";
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
    if ((activeSourceArgs?.positional.isNotEmpty ?? false) ||
        (activeSourceArgs?.named.isNotEmpty ?? false)) {
      List<String> fallbackArgs = <String>[
        ...(activeSourceArgs?.positional ?? const <String>[]),
        ...(activeSourceArgs?.named.entries.map(
              (i) => "${i.key}: ${i.value}",
            ) ??
            const <String>[]),
      ];
      return "${builder.applyDefsF(typeName)}(${fallbackArgs.join(",")})";
    }

    return "${builder.applyDefsF(typeName)}()";
  }

  List<String> positionalArgs = <String>[];
  List<String> namedArgs = <String>[];
  int positionalParamIndex = 0;

  for (FormalParameterElement param in ctor.formalParameters) {
    String? paramName = param.name;
    if (paramName == null) {
      continue;
    }

    DartObject? value = _fieldValueOf(object, paramName);
    String? sourceArg;
    if (param.isNamed) {
      sourceArg = activeSourceArgs?.named[paramName];
    } else if ((activeSourceArgs?.positional.length ?? 0) >
        positionalParamIndex) {
      sourceArg = activeSourceArgs!.positional[positionalParamIndex];
    }
    if (!param.isNamed) {
      positionalParamIndex++;
    }

    if (value == null) {
      if (sourceArg != null) {
        if (param.isNamed) {
          namedArgs.add("$paramName: $sourceArg");
        } else {
          positionalArgs.add(sourceArg);
        }
      }
      continue;
    }

    String code = dartObjectToCode(
      value,
      builder,
      importUris,
      sourceExpression: sourceArg,
    );
    if (param.isNamed) {
      namedArgs.add("$paramName: $code");
    } else {
      positionalArgs.add(code);
    }
  }

  if (positionalArgs.isEmpty &&
      namedArgs.isEmpty &&
      ((activeSourceArgs?.positional.isNotEmpty ?? false) ||
          (activeSourceArgs?.named.isNotEmpty ?? false))) {
    positionalArgs.addAll(activeSourceArgs?.positional ?? const <String>[]);
    namedArgs.addAll(
      activeSourceArgs?.named.entries.map((i) => "${i.key}: ${i.value}") ??
          const <String>[],
    );
  }

  String args = [...positionalArgs, ...namedArgs].join(",");
  return "${builder.applyDefsF(typeName)}($args)";
}

DartObject? _fieldValueOf(DartObject object, String name) {
  DartObject? direct = object.getField(name);
  if (direct != null) {
    return direct;
  }

  try {
    dynamic rawFields = (object as dynamic).fields;
    if (rawFields is Map) {
      dynamic rawValue = rawFields[name];
      if (rawValue is DartObject) {
        return rawValue;
      }
    }
  } catch (_) {}

  return null;
}
