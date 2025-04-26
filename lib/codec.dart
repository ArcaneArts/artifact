import 'dart:convert';

import 'package:fast_log/fast_log.dart';

int _ =
    (() {
      ArtifactCodecUtil.r([ADateTimeCodec(), ADurationCodec()]);
      return 0;
    })();

class $At<T, R> {
  final T data;
  final R value;

  const $At(this.data, this.value);
}

Map<(Type, Type), ArtifactCodec> $artifactCodecs = {
  (String, String): const ANOOPCodec(),
  (int, int): const ANOOPCodec(),
  (double, double): const ANOOPCodec(),
  (bool, bool): const ANOOPCodec(),
};

bool $isPrimitive(Object? o) =>
    o == null || o is String || o is int || o is double || o is bool;

class ArtifactCodecUtil {
  static Iterable<R> a<T, R>(T t, List<$At> a) =>
      a.where((i) => i.data == t).map((i) => i.value);

  static String j(bool p, Map<String, dynamic> Function() map) =>
      p ? const JsonEncoder.withIndent("  ").convert(map()) : jsonEncode(map());

  static Map<String, dynamic> o(String j) => jsonDecode(j);

  static T p<T>(dynamic l) {
    if (T == String) {
      return l.toString() as T;
    }

    if (T == int) {
      return int.parse(l.toString()) as T;
    }

    if (T == double) {
      return double.parse(l.toString()) as T;
    }

    if (T == bool) {
      return (l.toString().toLowerCase() == "true") as T;
    }

    throw ArgumentError(
      "Cannot parse $l (${l.runtimeType}) to ${T.toString()}",
    );
  }

  static dynamic e(List<dynamic> e, dynamic i) {
    if (i == null) {
      return null;
    }
    if (i is int) {
      return i >= e.length || i < 0 ? null : e[i];
    }
    if (i is String) {
      for (dynamic j in e) {
        if (j is Enum) {
          if (j.name == i) {
            return j;
          }
        }

        if (j.toString() == i) {
          return j;
        }
      }
    }

    i = int.tryParse(i.toString());
    return i >= e.length || i < 0 ? null : e[i];
  }

  static void r(List<ArtifactCodec> c) {
    for (ArtifactCodec i in c) {
      i.$register();
    }
  }

  static Object? ea(Object? o) {
    _;
    for ((Type, Type) i in $artifactCodecs.keys) {
      if (i.$2 == o.runtimeType) {
        return $artifactCodecs[i]?.encode(o);
      }
    }

    if (!$isPrimitive(o)) {
      warn(
        "=====================================================================================================================================================",
      );
      warn(
        "[ARTIFACT] Missing Codec for encoding ${o.runtimeType}. Use @codec(${o.runtimeType}Codec()) on the field or on the class to teach Artifact how to handle ${o.runtimeType} classes.",
      );
      warn(
        "[ARTIFACT] To convert, your class should extend ArtifactCodec<PRIMITIVE, ${o.runtimeType}>. Make sure it has an empty const constructor. ",
      );
      warn(
        "[ARTIFACT] I.e. `class ${o.runtimeType}Codec extends ArtifactCodec<String, ${o.runtimeType}>` if it can convert to/from strings easily.",
      );
      warn(
        "[ARTIFACT] Then put @codec(${o.runtimeType}Codec()) on any field of any artifact model, OR on any field of any artifact class.",
      );
      warn(
        "[ARTIFACT] You also don't need to worry about lists or maps, just handle the specific type and put the codec anywhere.",
      );
      warn(
        "=====================================================================================================================================================",
      );
    }
    return o;
  }

  static Map<K, V> fe<K, V>(Iterable<MapEntry<K, V>> entries) =>
      Map.fromEntries(entries);

  static Object? da(Object? o, Type into) {
    _;
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

  void $register() {
    $artifactCodecs[(E, D)] = this;
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
