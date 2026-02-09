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

class ArtifactMirror extends ArtifactMirrorBase {
  final Object instance;
  final $AClass _clazz;

  const ArtifactMirror(this._clazz, this.instance);

  Iterable<ArtifactFieldMirror> get fields =>
      _clazz.fields.map((f) => ArtifactFieldMirror(f, instance));

  Iterable<ArtifactMethodMirror> get methods =>
      _clazz.methods.map((m) => ArtifactMethodMirror(m, instance));

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

  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  Iterable<T> getAnnotations<T>([Type? type]) => _clazz.annotations
      .whereType<T>()
      .where((a) => type == null ? true : a.runtimeType == type);
}

class ArtifactFieldMirror extends ArtifactMirrorBase {
  final $AFld field;
  final Object instance;

  const ArtifactFieldMirror(this.field, this.instance);

  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  Type get fieldType => field.fieldType;

  Type get iType => field.iType;

  String get name => field.name;

  Iterable<T> getAnnotations<T>([Type? type]) => field.annotations
      .whereType<T>()
      .where((a) => type == null ? true : a.runtimeType == type);

  ArtifactFieldMirror modify(Object? newValue) =>
      withInstance(field.setValue(instance, newValue));

  Object? get value => field.getValue(instance);

  ArtifactFieldMirror withInstance(Object newInstance) =>
      ArtifactFieldMirror(field, newInstance);
}

class ArtifactMethodMirror extends ArtifactMirrorBase {
  final $AMth method;
  final Object instance;

  const ArtifactMethodMirror(this.method, this.instance);

  bool hasAnnotation<T>([Type? type]) => getAnnotations<T>(type).isNotEmpty;

  Iterable<T> getAnnotations<T>([Type? type]) => method.annotations
      .whereType<T>()
      .where((a) => type == null ? true : a.runtimeType == type);
}
