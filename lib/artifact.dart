library artifact;

import 'dart:convert';

import 'package:artifact/codec.dart';
import 'package:artifact/runtime_util.dart';
import 'package:bson/bson.dart';
import 'package:fast_log/fast_log.dart';
import 'package:threshold/threshold.dart';
import 'package:toxic/extensions/iterable.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/events.dart';
export 'package:artifact/reflect.dart';
export 'package:artifact/runtime_util.dart';
export 'package:artifact/shrink.dart';

Map<String, ArtifactAccessor> _artifactRegistry = {};
Set<String> _registering = {};
String? $artifactCipher;

class ArtifactAccessor {
  final bool Function(dynamic) isArtifact;
  final Map<Type, $AClass> artifactMirror;
  final T Function<T>() constructArtifact;
  final Map<String, dynamic> Function(Object) artifactToMap;
  final T Function<T>(Map<String, dynamic>) artifactFromMap;

  ArtifactAccessor({
    required this.isArtifact,
    required this.artifactMirror,
    required this.constructArtifact,
    required this.artifactToMap,
    required this.artifactFromMap,
  });

  static Iterable<MapEntry<Type, $AClass>> get mirrorEntries sync* {
    for (ArtifactAccessor accessor in all) {
      yield* accessor.artifactMirror.entries;
    }
  }

  static Map<Type, $AClass> get mirror =>
      Map<Type, $AClass>.fromEntries(mirrorEntries);

  static $AClass? reflectType(Type type) {
    for (MapEntry<Type, $AClass> entry in mirrorEntries) {
      if (entry.key == type ||
          entry.value.classType == type ||
          entry.value.nullableType == type) {
        return entry.value;
      }
    }

    return null;
  }

  static $AClass? reflectObject(Object? instance) {
    if (instance == null) {
      return null;
    }

    return reflectType(instance.runtimeType);
  }

  static Iterable<MapEntry<Type, $AClass>> whereMirrors(
    bool Function(Type type, $AClass clazz) test,
  ) sync* {
    for (MapEntry<Type, $AClass> entry in mirrorEntries) {
      if (test(entry.key, entry.value)) {
        yield entry;
      }
    }
  }

  static Iterable<MapEntry<Type, $AClass>> withAnnotation<T>([
    Type? exactType,
  ]) => whereMirrors(
    (_, clazz) => _hasAnnotation<T>(clazz.annotations, exactType),
  );

  static Iterable<MapEntry<Type, $AClass>> withAnnotationType(
    Type annotationType,
  ) => whereMirrors(
    (_, clazz) => _hasAnnotationType(clazz.annotations, annotationType),
  );

  static Iterable<MapEntry<Type, $AClass>> withFieldAnnotation<T>([
    Type? exactType,
  ]) => whereMirrors(
    (_, clazz) => clazz.fields.any(
      (field) => _hasAnnotation<T>(field.annotations, exactType),
    ),
  );

  static Iterable<MapEntry<Type, $AClass>> withFieldAnnotationType(
    Type annotationType,
  ) => whereMirrors(
    (_, clazz) => clazz.fields.any(
      (field) => _hasAnnotationType(field.annotations, annotationType),
    ),
  );

  static Iterable<MapEntry<Type, $AClass>> withMethodAnnotation<T>([
    Type? exactType,
  ]) => whereMirrors(
    (_, clazz) => clazz.methods.any(
      (method) => _hasAnnotation<T>(method.annotations, exactType),
    ),
  );

  static Iterable<MapEntry<Type, $AClass>> withMethodAnnotationType(
    Type annotationType,
  ) => whereMirrors(
    (_, clazz) => clazz.methods.any(
      (method) => _hasAnnotationType(method.annotations, annotationType),
    ),
  );

  static Iterable<MapEntry<Type, $AClass>> withMixin<T>() => withMixinType(T);

  static Iterable<MapEntry<Type, $AClass>> withMixinType(Type mixinType) =>
      whereMirrors((_, clazz) => clazz.classMixins.contains(mixinType));

  static Iterable<MapEntry<Type, $AClass>> withInterface<T>() =>
      withInterfaceType(T);

  static Iterable<MapEntry<Type, $AClass>> withInterfaceType(
    Type interfaceType,
  ) =>
      whereMirrors((_, clazz) => clazz.classInterfaces.contains(interfaceType));

  static Iterable<MapEntry<Type, $AClass>> withExtends<T>() =>
      withExtendsType(T);

  static Iterable<MapEntry<Type, $AClass>> withExtendsType(Type extendsType) =>
      whereMirrors((_, clazz) => clazz.classExtends == extendsType);

  static $AClass? rawReflect(Type type) => reflectType(type);

  static $AClass<T>? blindReflect<T>() =>
      ArtifactAccessor.all.select((i) {
            try {
              i.constructArtifact<T>();
              return true;
            } catch (_) {}
            return false;
          })?.artifactMirror[T]
          as $AClass<T>?;

  static Iterable<ArtifactAccessor> get all => _artifactRegistry.values;

  static bool $i(String key) {
    bool b = _registering.contains(key);

    _registering.add(key);
    return b;
  }

  static void $r(String key, ArtifactAccessor accessor) {
    _artifactRegistry[key] = accessor;
    verbose(
      "Registered $key accessor with ${accessor.artifactMirror.length} mirrors",
    );
  }
}

bool _hasAnnotation<T>(Iterable<Object> annotations, [Type? exactType]) {
  for (Object annotation in annotations) {
    if (annotation is T &&
        (exactType == null || annotation.runtimeType == exactType)) {
      return true;
    }
  }

  return false;
}

bool _hasAnnotationType(Iterable<Object> annotations, Type annotationType) {
  for (Object annotation in annotations) {
    if (annotation.runtimeType == annotationType) {
      return true;
    }
  }

  return false;
}

const Artifact artifact = Artifact();

const AutoExport external = AutoExport();

const IgnoreExport internal = IgnoreExport();

class AutoExport {
  const AutoExport();
}

class IgnoreExport {
  const IgnoreExport();
}

class Artifact {
  final bool generateSchema;
  final bool compression;
  final bool reflection;

  const Artifact({
    this.generateSchema = false,
    this.compression = true,
    this.reflection = false,
  });
}

class ArtifactEncrypt {
  final bool encrypt;

  const ArtifactEncrypt({this.encrypt = true});
}

const ArtifactEncrypt encrypt = ArtifactEncrypt();
const ArtifactEncrypt retain = ArtifactEncrypt(encrypt: false);

class codec {
  final ArtifactCodec c;

  const codec(this.c);
}

class describe {
  final String description;

  const describe(this.description);
}

class rename {
  final String newName;

  const rename(this.newName);
}

class attach<T> {
  final T data;

  const attach(this.data);
}

class MethodParameters {
  final List<dynamic> orderedParameters;
  final Map<String, dynamic> namedParameters;

  MethodParameters({
    this.orderedParameters = const [],
    this.namedParameters = const {},
  });

  T o<T>(int i) => orderedParameters[i] as T;

  T n<T>(String name) => namedParameters[name] as T;
}

Type _getNullishType<T>() {
  Type _t<T>(List<T> x) => T;
  return _t(<T?>[]);
}

abstract class $Maker<T> {}

class $AT<T> {
  final List<$AT> a;
  final List<Enum> Function()? o;
  final bool e;

  const $AT([this.a = const <$AT>[]]) : e = false, o = null;
  const $AT.e(this.o) : e = true, a = const <$AT>[];

  Type get type => T;

  List<$AT> get typeArguments => a;

  R mapType<R>(R Function<X>() mapper) {
    return mapper<T>();
  }

  R mapValue<R>(Object? value, R Function<X>(X value) mapper) {
    return mapType<R>(<X>() => mapper<X>(value as X));
  }
}

class $AClass<T> {
  final List<Object> annotations;
  final List<$AFld> fields;
  final List<$AMth> methods;
  final T Function() constructor;
  final Type classExtends;
  final List<Type> classMixins;
  final List<Type> classInterfaces;
  final $AT<T> typeDescriptor;
  Type get classType => T;
  Type get nullableType => _getNullishType<T>();

  $AClass(
    this.annotations,
    this.fields,
    this.methods,
    this.constructor,
    this.classExtends,
    this.classInterfaces,
    this.classMixins, [
    $AT<T>? typeDescriptor,
  ]) : typeDescriptor = typeDescriptor ?? $AT<T>();

  $Maker<T> maker($Maker<T> Function() f) {
    return f();
  }

  R mapClassType<R>(R Function<X>() mapper) {
    return mapper<T>();
  }

  R mapClassValue<R>(Object? value, R Function<X>(X value) mapper) {
    return mapClassType<R>(<X>() => mapper<X>(value as X));
  }

  T construct() => constructor();

  bool hasAnnotation<T>() => annotations.any((a) => a is T);

  bool hasMixin<T>() => classMixins.contains(T);

  bool hasInterface<T>() => classInterfaces.contains(T);

  Iterable<$AMth> annotatedMethods<T>() sync* {
    for ($AMth method in methods) {
      if (method.annotations.any((a) => a is T)) {
        yield method;
      }
    }
  }

  Iterable<$AFld> annotatedFields<T>() sync* {
    for ($AFld field in fields) {
      if (field.annotations.any((a) => a is T)) {
        yield field;
      }
    }
  }
}

class $AMth<I, R> {
  final String name;
  final R Function(I, MethodParameters) method;
  final List<Type> orderedParameterTypes;
  final Map<String, Type> mappedParameterTypes;
  final List<Object> annotations;
  final $AT<R> returnTypeDescriptor;
  final List<$AT> orderedParameterTypeDescriptors;
  final Map<String, $AT> mappedParameterTypeDescriptors;

  Type get iType => I;
  Type get returnType => R;

  R call(I instance, MethodParameters params) => method(instance, params);

  T? annotationOf<T>() => annotations.whereType<T>().firstOrNull;

  $AMth(
    this.name,
    this.method,
    this.orderedParameterTypes,
    this.mappedParameterTypes,
    this.annotations, [
    $AT<R>? returnTypeDescriptor,
    List<$AT>? orderedParameterTypeDescriptors,
    Map<String, $AT>? mappedParameterTypeDescriptors,
  ]) : returnTypeDescriptor = returnTypeDescriptor ?? $AT<R>(),
       orderedParameterTypeDescriptors =
           orderedParameterTypeDescriptors ?? const <$AT>[],
       mappedParameterTypeDescriptors =
           mappedParameterTypeDescriptors ?? const <String, $AT>{};
}

class $AFld<I, T> {
  final String name;
  final T Function(I) getter;
  final I Function(I, T) setter;
  final List<Object> annotations;
  final $AT<T> typeDescriptor;
  Type get iType => I;
  Type get fieldType => T;

  T getValue(I instance) => getter(instance);

  I setValue(I instance, T value) => setter(instance, value);

  R mapOwnerType<R>(R Function<X>() mapper) {
    return mapper<I>();
  }

  R mapFieldType<R>(R Function<X>() mapper) {
    return mapper<T>();
  }

  R mapOwnerValue<R>(Object? value, R Function<X>(X value) mapper) {
    return mapOwnerType<R>(<X>() => mapper<X>(value as X));
  }

  R mapFieldValue<R>(Object? value, R Function<X>(X value) mapper) {
    return mapFieldType<R>(<X>() => mapper<X>(value as X));
  }

  T? annotationOf<T>() => annotations.whereType<T>().firstOrNull;

  $AFld(
    this.name,
    this.getter,
    this.setter,
    this.annotations, [
    $AT<T>? typeDescriptor,
  ]) : typeDescriptor = typeDescriptor ?? $AT<T>();
}

extension XArtifactMirror on Map<Type, $AClass> {
  Map<Type, $AClass> where(bool Function(Type, $AClass) t) =>
      Map.fromEntries(entries.where((e) => t(e.key, e.value)));

  Map<Type, $AClass> withAnnotation<T>([Type? exactType]) =>
      where((_, c) => _hasAnnotation<T>(c.annotations, exactType));

  Map<Type, $AClass> withAnnotationType(Type annotationType) =>
      where((_, c) => _hasAnnotationType(c.annotations, annotationType));

  Map<Type, $AClass> withFieldAnnotation<T>([Type? exactType]) => where(
    (_, c) => c.fields.any(
      (field) => _hasAnnotation<T>(field.annotations, exactType),
    ),
  );

  Map<Type, $AClass> withFieldAnnotationType(Type annotationType) => where(
    (_, c) => c.fields.any(
      (field) => _hasAnnotationType(field.annotations, annotationType),
    ),
  );

  Map<Type, $AClass> withMethodAnnotation<T>([Type? exactType]) => where(
    (_, c) => c.methods.any(
      (method) => _hasAnnotation<T>(method.annotations, exactType),
    ),
  );

  Map<Type, $AClass> withMethodAnnotationType(Type annotationType) => where(
    (_, c) => c.methods.any(
      (method) => _hasAnnotationType(method.annotations, annotationType),
    ),
  );

  Map<Type, $AClass> withMixin<T>() => withMixinType(T);

  Map<Type, $AClass> withMixinType(Type mixinType) =>
      where((_, c) => c.classMixins.contains(mixinType));

  Map<Type, $AClass> withInterface<T>() => withInterfaceType(T);

  Map<Type, $AClass> withInterfaceType(Type interfaceType) =>
      where((_, c) => c.classInterfaces.contains(interfaceType));

  Map<Type, $AClass> withExtends<T>() => withExtendsType(T);

  Map<Type, $AClass> withExtendsType(Type extendsType) =>
      where((_, c) => c.classExtends == extendsType);
}

class ArtifactModelExporter {
  final Map<String, dynamic> Function() data;

  const ArtifactModelExporter(this.data);

  String get bson => base64Encode(BsonCodec.serialize(data()).byteList);
  String get bsonCompressed => compress(bson);
  String get json => ArtifactDataUtil.j(false, data);
  String get jsonPretty => ArtifactDataUtil.j(true, data);
  String get yaml => ArtifactDataUtil.y(data);
  String get toon => ArtifactDataUtil.b(data);
  String get toml => ArtifactDataUtil.u(data);
  String get props => ArtifactDataUtil.h(data);
}

class ArtifactModelImporter<T> {
  final T Function(Map<String, dynamic>) fromMap;

  const ArtifactModelImporter(this.fromMap);

  T bson(String data, {bool compressed = false}) => fromMap(
    BsonCodec.deserialize(
      BsonBinary.from(base64Decode(compressed ? decompress(data) : data)),
    ),
  );
  T json(String data) => fromMap(ArtifactDataUtil.o(data));
  T yaml(String data) => fromMap(ArtifactDataUtil.v(data));
  T toon(String data) => fromMap(ArtifactDataUtil.i(data));
  T toml(String data) => fromMap(ArtifactDataUtil.t(data));
  T props(String data) => fromMap(ArtifactDataUtil.g(data));
}
