library artifact;

import 'dart:convert';

import 'package:artifact/codec.dart';
import 'package:bson/bson.dart';
import 'package:fast_log/fast_log.dart';
import 'package:threshold/threshold.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/events.dart';
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

const Artifact artifact = Artifact();

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

class $AClass<T> {
  final List<Object> annotations;
  final List<$AFld> fields;
  final List<$AMth> methods;
  final T Function() constructor;
  final Type classExtends;
  final List<Type> classMixins;
  final List<Type> classInterfaces;
  Type get classType => T;

  const $AClass(
    this.annotations,
    this.fields,
    this.methods,
    this.constructor,
    this.classExtends,
    this.classInterfaces,
    this.classMixins,
  );

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

  Type get iType => I;
  Type get returnType => R;

  R call(I instance, MethodParameters params) => method(instance, params);

  T? annotationOf<T>() => annotations.whereType<T>().firstOrNull;

  const $AMth(
    this.name,
    this.method,
    this.orderedParameterTypes,
    this.mappedParameterTypes,
    this.annotations,
  );
}

class $AFld<I, T> {
  final String name;
  final T Function(I) getter;
  final I Function(I, T) setter;
  final List<Object> annotations;
  Type get iType => I;
  Type get fieldType => T;

  T getValue(I instance) => getter(instance);

  I setValue(I instance, T value) => setter(instance, value);

  T? annotationOf<T>() => annotations.whereType<T>().firstOrNull;

  const $AFld(this.name, this.getter, this.setter, this.annotations);
}

extension XArtifactMirror on Map<Type, $AClass> {
  Map<Type, $AClass> where(bool Function(Type, $AClass) t) =>
      Map.fromEntries(entries.where((e) => t(e.key, e.value)));

  Map<Type, $AClass> withAnnotation<T>() =>
      where((t, c) => c.hasAnnotation<T>());

  Map<Type, $AClass> withMixin<T>() => where((t, c) => c.hasMixin<T>());

  Map<Type, $AClass> withInterface<T>() => where((t, c) => c.hasInterface<T>());

  Map<Type, $AClass> withExtends<T>() => where((t, c) => c.classExtends == T);
}

class ArtifactModelExporter {
  final Map<String, dynamic> Function() data;

  const ArtifactModelExporter(this.data);

  String get bson => base64Encode(BsonCodec.serialize(data()).byteList);
  String get bsonCompressed => compress(bson);
  String get json => ArtifactCodecUtil.j(false, data);
  String get jsonPretty => ArtifactCodecUtil.j(true, data);
  String get yaml => ArtifactCodecUtil.y(data);
  String get toon => ArtifactCodecUtil.b(data);
  String get toml => ArtifactCodecUtil.u(data);
  String get xml => ArtifactCodecUtil.z(false, data);
  String get xmlPretty => ArtifactCodecUtil.z(true, data);
  String get props => ArtifactCodecUtil.h(data);
}

class ArtifactModelImporter<T> {
  final T Function(Map<String, dynamic>) fromMap;

  const ArtifactModelImporter(this.fromMap);

  T bson(String data, {bool compressed = false}) => fromMap(
    BsonCodec.deserialize(
      BsonBinary.from(base64Decode(compressed ? decompress(data) : data)),
    ),
  );
  T json(String data) => fromMap(ArtifactCodecUtil.o(data));
  T yaml(String data) => fromMap(ArtifactCodecUtil.v(data));
  T toon(String data) => fromMap(ArtifactCodecUtil.i(data));
  T toml(String data) => fromMap(ArtifactCodecUtil.t(data));
  T props(String data) => fromMap(ArtifactCodecUtil.g(data));
}
