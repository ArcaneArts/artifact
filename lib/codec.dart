Map<(Type, Type), ArtifactCodec> $artifactCodecs = {
  (String, DateTime): const ADateTimeCodec(),
  (int, Duration): const ADurationCodec(),
  (String, String): const ANOOPCodec(),
  (int, int): const ANOOPCodec(),
  (double, double): const ANOOPCodec(),
  (bool, bool): const ANOOPCodec(),
};

class ArtifactCodecUtil {
  static Object? ea(Object? o) {
    for ((Type, Type) i in $artifactCodecs.keys) {
      if (i.$2 == o.runtimeType) {
        return $artifactCodecs[i]?.encode(o);
      }
    }

    return o;
  }

  static Object? da(Object? o, Type into) {
    for ((Type, Type) i in $artifactCodecs.keys) {
      if (i.$1 == o.runtimeType && i.$2 == into) {
        return $artifactCodecs[i]?.decode(o);
      }
    }

    return o;
  }

  static E? ef<E, D>(D? d) => $artifactCodecs[(E, D)]?.encode(d);

  static D? df<E, D>(E? e) => $artifactCodecs[(E, D)]?.decode(e);
}

abstract class ArtifactCodec<E, D> {
  const ArtifactCodec();

  E? encode(D? value);

  D? decode(E? value);
}

class ANOOPCodec extends ArtifactCodec<Object?, Object?> {
  const ANOOPCodec();

  @override
  Object? decode(Object? value) => value;

  @override
  Object? encode(Object? value) => value;
}

class ADateTimeCodec extends ArtifactCodec<String, DateTime> {
  const ADateTimeCodec();

  @override
  String? encode(DateTime? value) => value?.toIso8601String();

  @override
  DateTime? decode(String? value) =>
      value == null ? null : DateTime.tryParse(value);
}

class ADurationCodec extends ArtifactCodec<int, Duration> {
  const ADurationCodec();

  @override
  int? encode(Duration? value) => value?.inMilliseconds;

  @override
  Duration? decode(int? value) =>
      value == null ? null : Duration(milliseconds: value);
}
