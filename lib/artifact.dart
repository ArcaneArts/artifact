library artifact;

import 'package:artifact/codec.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/shrink.dart';

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
