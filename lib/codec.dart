import 'package:fast_log/fast_log.dart';

int _ =
    (() {
      ArtifactCodecUtil.r([ADateTimeCodec(), ADurationCodec()]);
      return 0;
    })();

Map<(Type, Type), ArtifactCodec> $artifactCodecs = {
  (String, String): const ANOOPCodec(),
  (int, int): const ANOOPCodec(),
  (double, double): const ANOOPCodec(),
  (bool, bool): const ANOOPCodec(),
  (int, double): const IntToDoubleCodec(),
  (String, int): const StringToInt(),
  (String, double): const StringToDouble(),
  (String, bool): const StringToBool(),
};

bool $isPrimitive(Object? value) =>
    value == null ||
    value is String ||
    value is int ||
    value is double ||
    value is bool;

class ArtifactCodecUtil {
  static void r(List<ArtifactCodec> codecs) {
    for (ArtifactCodec codec in codecs) {
      codec.$register();
    }
  }

  static Object? ea(Object? value) {
    _;
    for ((Type, Type) key in $artifactCodecs.keys) {
      if (key.$2 == value.runtimeType) {
        return $artifactCodecs[key]?.encode(value);
      }
    }

    if (!$isPrimitive(value)) {
      warn(
        "=====================================================================================================================================================",
      );
      warn(
        "[ARTIFACT] Missing Codec for encoding ${value.runtimeType}. Use @codec(${value.runtimeType}Codec()) on the field or on the class to teach Artifact how to handle ${value.runtimeType} classes.",
      );
      warn(
        "[ARTIFACT] To convert, your class should extend ArtifactCodec<PRIMITIVE, ${value.runtimeType}>. Make sure it has an empty const constructor. ",
      );
      warn(
        "[ARTIFACT] I.e. `class ${value.runtimeType}Codec extends ArtifactCodec<String, ${value.runtimeType}>` if it can convert to/from strings easily.",
      );
      warn(
        "[ARTIFACT] Then put @codec(${value.runtimeType}Codec()) on any field of any artifact model, OR on any field of any artifact class.",
      );
      warn(
        "[ARTIFACT] You also don't need to worry about lists or maps, just handle the specific type and put the codec anywhere.",
      );
      warn(
        "=====================================================================================================================================================",
      );
    }

    return value;
  }

  static Object? da(Object? value, Type into) {
    _;
    for ((Type, Type) key in $artifactCodecs.keys) {
      if (key.$1 == value.runtimeType && key.$2 == into) {
        return $artifactCodecs[key]?.decode(value);
      }
    }

    return value;
  }

  static E? ef<E, D>(D? value) => $artifactCodecs[(E, D)]?.encode(value);

  static D? df<E, D>(E? value) => $artifactCodecs[(E, D)]?.decode(value);
}

abstract class ArtifactCodec<E, D> {
  const ArtifactCodec();

  E? encode(D? value);

  D? decode(E? value);

  void $register() {
    $artifactCodecs[(E, D)] = this;
  }
}

class IntToDoubleCodec extends ArtifactCodec<int, double> {
  const IntToDoubleCodec();

  @override
  double? decode(int? value) => value?.toDouble();

  @override
  int? encode(double? value) {
    warn(
      "Encode called on IntToDoubleCodec causing loss of precision! Notify Artifact team.",
    );
    return value?.toInt();
  }
}

class StringToInt extends ArtifactCodec<String, int> {
  const StringToInt();

  @override
  int? decode(String? value) => value == null ? null : int.tryParse(value) ?? 0;

  @override
  String? encode(int? value) {
    return value.toString();
  }
}

class StringToDouble extends ArtifactCodec<String, double> {
  const StringToDouble();

  @override
  double? decode(String? value) =>
      value == null ? null : double.tryParse(value) ?? 0;

  @override
  String? encode(double? value) {
    return value.toString();
  }
}

class StringToBool extends ArtifactCodec<String, bool> {
  const StringToBool();

  @override
  bool? decode(String? value) =>
      value == null ? null : value.toLowerCase() == "true";

  @override
  String? encode(bool? value) {
    return value.toString();
  }
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
