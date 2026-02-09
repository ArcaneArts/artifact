import 'package:artifact/artifact.dart';

abstract class ArtifactMirrorBase {
  const ArtifactMirrorBase();

  bool hasAnnotation<T>([Type? type]);

  Iterable<T> getAnnotations<T>([Type? type]);
}

class ArtifactAnnotatedMethod<A> {
  final A annotation;
  final ArtifactMethodMirror method;
  final Object instance;

  const ArtifactAnnotatedMethod(this.annotation, this.method, this.instance);
}

class ArtifactAnnotatedField<A> {
  final A annotation;
  final ArtifactFieldMirror field;
  final Object instance;

  const ArtifactAnnotatedField(this.annotation, this.field, this.instance);
}

class ArtifactReflection {
  const ArtifactReflection._();

  static Iterable<ArtifactTypeMirror> get types sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.mirrorEntries) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static ArtifactTypeMirror? typeOf(Type type) {
    $AClass? clazz = ArtifactAccessor.reflectType(type);
    if (clazz == null) {
      return null;
    }

    return ArtifactTypeMirror(clazz.classType, clazz);
  }

  static ArtifactMirror? instanceOf(Object instance) {
    $AClass? clazz = ArtifactAccessor.reflectObject(instance);
    if (clazz == null) {
      return null;
    }

    return ArtifactMirror(clazz, instance);
  }

  static Iterable<ArtifactTypeMirror> withAnnotation<T>([
    Type? exactType,
  ]) sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withAnnotation<T>(
      exactType,
    )) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withAnnotationType(
    Type annotationType,
  ) sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withAnnotationType(
      annotationType,
    )) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withFieldAnnotation<T>([
    Type? exactType,
  ]) sync* {
    for (MapEntry<Type, $AClass> entry
        in ArtifactAccessor.withFieldAnnotation<T>(exactType)) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withFieldAnnotationType(
    Type annotationType,
  ) sync* {
    for (MapEntry<Type, $AClass> entry
        in ArtifactAccessor.withFieldAnnotationType(annotationType)) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withMethodAnnotation<T>([
    Type? exactType,
  ]) sync* {
    for (MapEntry<Type, $AClass> entry
        in ArtifactAccessor.withMethodAnnotation<T>(exactType)) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withMethodAnnotationType(
    Type annotationType,
  ) sync* {
    for (MapEntry<Type, $AClass> entry
        in ArtifactAccessor.withMethodAnnotationType(annotationType)) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withMixin<T>() sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withMixin<T>()) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withMixinType(Type mixinType) sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withMixinType(
      mixinType,
    )) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withInterface<T>() sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withInterface<T>()) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withInterfaceType(
    Type interfaceType,
  ) sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withInterfaceType(
      interfaceType,
    )) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withExtends<T>() sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withExtends<T>()) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }

  static Iterable<ArtifactTypeMirror> withExtendsType(Type extendsType) sync* {
    for (MapEntry<Type, $AClass> entry in ArtifactAccessor.withExtendsType(
      extendsType,
    )) {
      yield ArtifactTypeMirror(entry.value.classType, entry.value);
    }
  }
}

class ArtifactTypeMirror extends ArtifactMirrorBase {
  final Type type;
  final $AClass clazz;

  const ArtifactTypeMirror(this.type, this.clazz);

  Type get classType => clazz.classType;

  Type get nullableType => clazz.nullableType;

  Type get classExtends => clazz.classExtends;

  List<Type> get classInterfaces => List<Type>.from(clazz.classInterfaces);

  List<Type> get classMixins => List<Type>.from(clazz.classMixins);

  Iterable<ArtifactFieldInfo> get fields =>
      clazz.fields.map((field) => ArtifactFieldInfo(field));

  Iterable<ArtifactMethodInfo> get methods =>
      clazz.methods.map((method) => ArtifactMethodInfo(method));

  ArtifactFieldInfo? field(String name) =>
      _firstWhereOrNull(fields, (f) => f.name == name);

  ArtifactMethodInfo? method(String name) =>
      _firstWhereOrNull(methods, (m) => m.name == name);

  Object construct() => clazz.construct();

  ArtifactMirror bind(Object instance) => ArtifactMirror(clazz, instance);

  R mapClassType<R>(R Function<T>() mapper) => clazz.mapClassType(mapper);

  R mapClassValue<R>(Object? value, R Function<T>(T value) mapper) =>
      clazz.mapClassValue(value, mapper);

  Iterable<ArtifactFieldInfo> annotatedFields<T>([Type? type]) =>
      fields.where((field) => field.hasAnnotation<T>(type));

  Iterable<ArtifactMethodInfo> annotatedMethods<T>([Type? type]) =>
      methods.where((method) => method.hasAnnotation<T>(type));

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(clazz.annotations, type);
}

class ArtifactFieldInfo extends ArtifactMirrorBase {
  final $AFld field;

  const ArtifactFieldInfo(this.field);

  String get name => field.name;

  Type get fieldType => field.fieldType;

  Type get ownerType => field.iType;

  Object? getValue(Object instance) => field.getValue(instance);

  Object setValue(Object instance, Object? value) =>
      field.setValue(instance, value);

  ArtifactFieldMirror bind(Object instance) =>
      ArtifactFieldMirror(field, instance);

  R mapOwnerType<R>(R Function<T>() mapper) => field.mapOwnerType(mapper);

  R mapFieldType<R>(R Function<T>() mapper) => field.mapFieldType(mapper);

  R mapOwnerValue<R>(Object? value, R Function<T>(T value) mapper) =>
      field.mapOwnerValue(value, mapper);

  R mapFieldValue<R>(Object? value, R Function<T>(T value) mapper) =>
      field.mapFieldValue(value, mapper);

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(field.annotations, type);
}

class ArtifactMethodInfo extends ArtifactMirrorBase {
  final $AMth method;

  const ArtifactMethodInfo(this.method);

  String get name => method.name;

  Type get ownerType => method.iType;

  Type get returnType => method.returnType;

  List<Type> get orderedParameterTypes =>
      List<Type>.from(method.orderedParameterTypes);

  Map<String, Type> get namedParameterTypes =>
      Map<String, Type>.from(method.mappedParameterTypes);

  Object? call(
    Object instance, {
    List<dynamic> orderedParameters = const <dynamic>[],
    Map<String, dynamic> namedParameters = const <String, dynamic>{},
  }) {
    return method(
      instance,
      MethodParameters(
        orderedParameters: orderedParameters,
        namedParameters: namedParameters,
      ),
    );
  }

  ArtifactMethodMirror bind(Object instance) =>
      ArtifactMethodMirror(method, instance);

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(method.annotations, type);
}

class ArtifactMirror extends ArtifactMirrorBase {
  final Object instance;
  final $AClass _clazz;

  const ArtifactMirror(this._clazz, this.instance);

  ArtifactTypeMirror get type => ArtifactTypeMirror(_clazz.classType, _clazz);

  R mapClassType<R>(R Function<T>() mapper) => _clazz.mapClassType(mapper);

  R mapClassValue<R>(R Function<T>(T value) mapper) =>
      _clazz.mapClassValue(instance, mapper);

  Iterable<ArtifactFieldMirror> get fields =>
      _clazz.fields.map((f) => ArtifactFieldMirror(f, instance));

  Iterable<ArtifactMethodMirror> get methods =>
      _clazz.methods.map((m) => ArtifactMethodMirror(m, instance));

  ArtifactFieldMirror? field(String name) =>
      _firstWhereOrNull(fields, (field) => field.name == name);

  ArtifactMethodMirror? method(String name) =>
      _firstWhereOrNull(methods, (method) => method.name == name);

  Object? getFieldValue(String name) => field(name)?.value;

  ArtifactMirror setFieldValue(String name, Object? value) {
    ArtifactFieldMirror? f = field(name);
    if (f == null) {
      throw ArgumentError("Unknown field $name on ${instance.runtimeType}");
    }

    return ArtifactMirror(_clazz, f.modify(value).instance);
  }

  Object? callMethod(
    String name, {
    List<dynamic> orderedParameters = const <dynamic>[],
    Map<String, dynamic> namedParameters = const <String, dynamic>{},
  }) {
    ArtifactMethodMirror? m = method(name);
    if (m == null) {
      throw ArgumentError("Unknown method $name on ${instance.runtimeType}");
    }

    return m.call(
      orderedParameters: orderedParameters,
      namedParameters: namedParameters,
    );
  }

  Iterable<ArtifactAnnotatedMethod<T>> getAnnotatedMethods<T>([Type? t]) sync* {
    for (ArtifactMethodMirror i in methods) {
      if (i.hasAnnotation<T>(t)) {
        for (T a in i.getAnnotations<T>(t)) {
          yield ArtifactAnnotatedMethod<T>(a, i, instance);
        }
      }
    }
  }

  Iterable<ArtifactAnnotatedField<T>> getAnnotatedFields<T>([Type? t]) sync* {
    for (ArtifactFieldMirror i in fields) {
      if (i.hasAnnotation<T>(t)) {
        for (T a in i.getAnnotations<T>(t)) {
          yield ArtifactAnnotatedField<T>(a, i, instance);
        }
      }
    }
  }

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(_clazz.annotations, type);
}

class ArtifactFieldMirror extends ArtifactMirrorBase {
  final $AFld field;
  final Object instance;

  const ArtifactFieldMirror(this.field, this.instance);

  ArtifactFieldInfo get info => ArtifactFieldInfo(field);

  Type get fieldType => field.fieldType;

  Type get iType => field.iType;

  String get name => field.name;

  Object? get value => field.getValue(instance);

  ArtifactFieldMirror modify(Object? newValue) =>
      withInstance(field.setValue(instance, newValue));

  ArtifactFieldMirror withInstance(Object newInstance) =>
      ArtifactFieldMirror(field, newInstance);

  R mapOwnerType<R>(R Function<T>() mapper) => field.mapOwnerType(mapper);

  R mapFieldType<R>(R Function<T>() mapper) => field.mapFieldType(mapper);

  R mapOwnerValue<R>(R Function<T>(T value) mapper) =>
      field.mapOwnerValue(instance, mapper);

  R mapFieldValue<R>(R Function<T>(T value) mapper) =>
      field.mapFieldValue(value, mapper);

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(field.annotations, type);
}

class ArtifactMethodMirror extends ArtifactMirrorBase {
  final $AMth method;
  final Object instance;

  const ArtifactMethodMirror(this.method, this.instance);

  ArtifactMethodInfo get info => ArtifactMethodInfo(method);

  String get name => method.name;

  Type get iType => method.iType;

  Type get returnType => method.returnType;

  List<Type> get orderedParameterTypes =>
      List<Type>.from(method.orderedParameterTypes);

  Map<String, Type> get namedParameterTypes =>
      Map<String, Type>.from(method.mappedParameterTypes);

  Object? call({
    List<dynamic> orderedParameters = const <dynamic>[],
    Map<String, dynamic> namedParameters = const <String, dynamic>{},
  }) {
    return method(
      instance,
      MethodParameters(
        orderedParameters: orderedParameters,
        namedParameters: namedParameters,
      ),
    );
  }

  @override
  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  @override
  Iterable<T> getAnnotations<T>([Type? type]) =>
      _annotationsOf<T>(method.annotations, type);
}

Iterable<T> _annotationsOf<T>(
  Iterable<Object> annotations, [
  Type? type,
]) sync* {
  for (Object annotation in annotations) {
    if (annotation is T && (type == null || annotation.runtimeType == type)) {
      yield annotation as T;
    }
  }
}

T? _firstWhereOrNull<T>(Iterable<T> values, bool Function(T) test) {
  for (T value in values) {
    if (test(value)) {
      return value;
    }
  }

  return null;
}
