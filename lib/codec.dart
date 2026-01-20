import 'dart:convert';

import 'package:artifact/artifact.dart';
import 'package:artifact/reflect.dart';
import 'package:fast_log/fast_log.dart';
import 'package:json_compress/json_compress.dart';
import 'package:toml/toml.dart';
import 'package:toonx/toonx.dart' as toonx;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

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
  (int, double): const IntToDoubleCodec(),
  (String, int): const StringToInt(),
  (String, double): const StringToDouble(),
  (String, bool): const StringToBool(),
};

bool $isPrimitive(Object? o) =>
    o == null || o is String || o is int || o is double || o is bool;

class ArtifactCodecUtil {
  static Iterable<R> a<T, R>(T t, List<$At> a) =>
      a.where((i) => i.data == t).map((i) => i.value);

  static Map<String, dynamic> s(Map<String, dynamic> t) {
    if ($artifactCipher == null || $artifactCipher!.isEmpty) {
      throw Exception("\$artifactCipher is undefined! cannot decompress json!");
    }

    return decompressDecryptJson(
      t,
      encryptionKey: $artifactCipher!,
      ignoreWarnings: true,
      keepUnknownKeys: true,
    );
  }

  static Map<String, dynamic> q(Map<String, dynamic> t, List<String>? retain) {
    if (retain == null) {
      return t;
    }

    if ($artifactCipher == null || $artifactCipher!.isEmpty) {
      throw Exception("\$artifactCipher is undefined! cannot compress json!");
    }

    return compressEncryptJson(
      t,
      encryptionKey: $artifactCipher!,
      retainer: retain.isEmpty ? null : (k, v) => retain.contains(k),
    );
  }

  static ArtifactMirror? m(Object instance) {
    $AClass? c =
        ArtifactAccessor.all
            .where((i) => i.artifactMirror.containsKey(instance.runtimeType))
            .firstOrNull
            ?.artifactMirror[instance.runtimeType];
    if (c == null) {
      return null;
    }

    return ArtifactMirror(c, instance);
  }

  static String j(bool p, Map<String, dynamic> Function() map) =>
      p ? const JsonEncoder.withIndent("  ").convert(map()) : jsonEncode(map());

  static String b(Map<String, dynamic> Function() map) => toonx.encode(map());

  static String y(Map<String, dynamic> Function() map) =>
      (YamlEditor('')..update([], map())).toString();

  static String u(Map<String, dynamic> Function() map) =>
      TomlDocument.fromMap(map()).toString();

  static String h(Map<String, dynamic> Function() map) =>
      PropertiesConverter.toProperties(map());

  static Map<String, dynamic> o(String j) => jsonDecode(j);

  static Map<String, dynamic> i(String j) => toonx.decode(j);

  static Map<String, dynamic> v(String y) => Map.from(loadYaml(y));

  static Map<String, dynamic> t(String t) => TomlDocument.parse(t).toMap();

  static Map<String, dynamic> g(String properties) =>
      PropertiesConverter.fromProperties(properties);

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
  int? decode(String? value) =>
      value == null ? null : int.tryParse(value ?? "") ?? 0;

  @override
  String? encode(int? value) {
    return value.toString();
  }
}

class StringToDouble extends ArtifactCodec<String, double> {
  const StringToDouble();

  @override
  double? decode(String? value) =>
      value == null ? null : double.tryParse(value ?? "") ?? 0;

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

class PropertiesConverter {
  static String toProperties(Map<String, dynamic> map) {
    final lines = <String>[];
    _serialize(map, '', lines);
    return lines.join('\n');
  }

  static void _serialize(dynamic obj, String prefix, List<String> lines) {
    if (obj is Map<String, dynamic>) {
      obj.forEach((key, value) {
        final newPrefix = prefix.isEmpty ? key : '$prefix.$key';
        _serialize(value, newPrefix, lines);
      });
    } else if (obj is List<dynamic>) {
      for (var i = 0; i < obj.length; i++) {
        final newPrefix = prefix.isEmpty ? '$i' : '$prefix.$i';
        _serialize(obj[i], newPrefix, lines);
      }
    } else {
      String valStr;
      if (obj is String) {
        valStr = '"${obj.replaceAll('"', '\\"')}"';
      } else if (obj is num) {
        valStr = obj.toString();
      } else if (obj is bool) {
        valStr = obj.toString().toLowerCase();
      } else {
        valStr = obj.toString();
      }
      lines.add('$prefix=$valStr');
    }
  }

  static Map<String, dynamic> fromProperties(String input) {
    final root = <String, dynamic>{};
    final lines =
        input
            .split('\n')
            .map((l) => l.trim())
            .where((l) => l.isNotEmpty)
            .toList();
    for (final line in lines) {
      final eqIdx = line.indexOf('=');
      if (eqIdx == -1) continue;
      final path = line.substring(0, eqIdx).trim();
      final valStr = line.substring(eqIdx + 1);
      final value = _parseValue(valStr);
      final segments = path.split('.');
      _setByPath(root, segments, value);
    }
    return root;
  }

  static dynamic _parseValue(String valStr) {
    valStr = valStr.trim();
    if (valStr.startsWith('"') && valStr.endsWith('"')) {
      return valStr.substring(1, valStr.length - 1).replaceAll('\\"', '"');
    }
    final i = int.tryParse(valStr);
    if (i != null) return i;
    final d = double.tryParse(valStr);
    if (d != null) return d;
    if (valStr.toLowerCase() == 'true') return true;
    if (valStr.toLowerCase() == 'false') return false;
    return valStr;
  }

  static void _setByPath(
    Map<String, dynamic> root,
    List<String> segments,
    dynamic value,
  ) {
    if (segments.isEmpty) return;
    dynamic current = root;
    for (var i = 0; i < segments.length; i++) {
      final isLast = i == segments.length - 1;
      final seg = segments[i];
      final idx = int.tryParse(seg);
      final isIndex = idx != null;
      if (isLast) {
        if (current is Map<String, dynamic> && !isIndex) {
          current[seg] = value;
        } else if (current is List<dynamic> && isIndex) {
          while (current.length <= idx!) {
            current.add(null);
          }
          current[idx] = value;
        } else {
          throw Exception(
            'Type mismatch at path ${segments.sublist(0, i + 1).join('.')}',
          );
        }
      } else {
        final nextSeg = segments[i + 1];
        final nextIdx = int.tryParse(nextSeg);
        final nextIsIndex = nextIdx != null;
        if (current is Map<String, dynamic>) {
          if (isIndex) {
            throw Exception(
              'Index on map at ${segments.sublist(0, i).join('.')}',
            );
          }
          current = current.putIfAbsent(
            seg,
            () => nextIsIndex ? <dynamic>[] : <String, dynamic>{},
          );
        } else if (current is List<dynamic>) {
          if (!isIndex) {
            throw Exception(
              'String key on list at ${segments.sublist(0, i).join('.')}',
            );
          }
          while (current.length <= idx!) {
            current.add(null);
          }
          if (current[idx] == null) {
            current[idx] = nextIsIndex ? <dynamic>[] : <String, dynamic>{};
          }
          current = current[idx];
        } else {
          throw Exception(
            'Invalid container at ${segments.sublist(0, i).join('.')}',
          );
        }
      }
    }
  }
}
