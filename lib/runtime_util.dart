import 'dart:convert';

import 'package:json_compress/json_compress.dart';
import 'package:toml/toml.dart';
import 'package:toonx/toonx.dart' as toonx;
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

class ArtifactDataUtil {
  static const String _tomlNullSentinel = r'$artifact_toml_null$';
  static const String _tomlEscapedNullSentinel =
      r'$artifact_toml_escaped_null$';

  static String j(bool pretty, Map<String, dynamic> Function() map) =>
      pretty
          ? const JsonEncoder.withIndent("  ").convert(map())
          : jsonEncode(map());

  static String b(Map<String, dynamic> Function() map) => toonx.encode(map());

  static String y(Map<String, dynamic> Function() map) =>
      (YamlEditor('')..update([], map())).toString();

  static String u(Map<String, dynamic> Function() map) =>
      TomlDocument.fromMap(_toTomlSafeMap(map())).toString();

  static String h(Map<String, dynamic> Function() map) =>
      PropertiesConverter.toProperties(map());

  static Map<String, dynamic> o(String data) => jsonDecode(data);

  static Map<String, dynamic> i(String data) => toonx.decode(data);

  static Map<String, dynamic> v(String data) {
    dynamic parsed = loadYaml(data);
    dynamic normalized = _yamlToDart(parsed);

    if (normalized is Map<String, dynamic>) {
      return normalized;
    }

    if (normalized is Map) {
      Map<String, dynamic> out = <String, dynamic>{};
      normalized.forEach((dynamic key, dynamic value) {
        out[key.toString()] = value;
      });
      return out;
    }

    return <String, dynamic>{};
  }

  static Map<String, dynamic> t(String data) =>
      _fromTomlSafeMap(TomlDocument.parse(data).toMap());

  static Map<String, dynamic> g(String properties) =>
      PropertiesConverter.fromProperties(properties);

  static T p<T>(dynamic value) {
    if (T == String) {
      return value.toString() as T;
    }

    if (T == int) {
      return int.parse(value.toString()) as T;
    }

    if (T == double) {
      return double.parse(value.toString()) as T;
    }

    if (T == bool) {
      return (value.toString().toLowerCase() == "true") as T;
    }

    throw ArgumentError(
      "Cannot parse $value (${value.runtimeType}) to ${T.toString()}",
    );
  }

  static dynamic e(List<dynamic> enums, dynamic indexOrName) {
    if (indexOrName == null) {
      return null;
    }

    if (indexOrName is int) {
      return indexOrName >= enums.length || indexOrName < 0
          ? null
          : enums[indexOrName];
    }

    if (indexOrName is String) {
      for (dynamic entry in enums) {
        if (entry is Enum) {
          if (entry.name == indexOrName) {
            return entry;
          }
        }

        if (entry.toString() == indexOrName) {
          return entry;
        }
      }
    }

    indexOrName = int.tryParse(indexOrName.toString());
    return indexOrName >= enums.length || indexOrName < 0
        ? null
        : enums[indexOrName];
  }

  static Map<K, V> fe<K, V>(Iterable<MapEntry<K, V>> entries) =>
      Map.fromEntries(entries);

  static dynamic _yamlToDart(dynamic value) {
    if (value is YamlMap) {
      Map<String, dynamic> out = <String, dynamic>{};
      value.forEach((dynamic key, dynamic nestedValue) {
        out[key.toString()] = _yamlToDart(nestedValue);
      });
      return out;
    }

    if (value is Map) {
      Map<String, dynamic> out = <String, dynamic>{};
      value.forEach((dynamic key, dynamic nestedValue) {
        out[key.toString()] = _yamlToDart(nestedValue);
      });
      return out;
    }

    if (value is YamlList) {
      List<dynamic> out = <dynamic>[];
      for (dynamic entry in value) {
        out.add(_yamlToDart(entry));
      }
      return out;
    }

    if (value is List) {
      List<dynamic> out = <dynamic>[];
      for (dynamic entry in value) {
        out.add(_yamlToDart(entry));
      }
      return out;
    }

    return value;
  }

  static Map<String, dynamic> _toTomlSafeMap(Map<String, dynamic> source) {
    Map<String, dynamic> out = <String, dynamic>{};
    source.forEach((String key, dynamic value) {
      out[key] = _toTomlSafeValue(value);
    });
    return out;
  }

  static dynamic _toTomlSafeValue(dynamic value) {
    if (value == null) {
      return _tomlNullSentinel;
    }

    if (value is String) {
      if (value == _tomlNullSentinel) {
        return _tomlEscapedNullSentinel;
      }
      return value;
    }

    if (value is Map) {
      Map<String, dynamic> out = <String, dynamic>{};
      value.forEach((dynamic key, dynamic nestedValue) {
        out[key.toString()] = _toTomlSafeValue(nestedValue);
      });
      return out;
    }

    if (value is List) {
      return value.map(_toTomlSafeValue).toList();
    }

    if (value is Set) {
      return value.map(_toTomlSafeValue).toList();
    }

    return value;
  }

  static Map<String, dynamic> _fromTomlSafeMap(Map<String, dynamic> source) {
    Map<String, dynamic> out = <String, dynamic>{};
    source.forEach((String key, dynamic value) {
      out[key] = _fromTomlSafeValue(value);
    });
    return out;
  }

  static dynamic _fromTomlSafeValue(dynamic value) {
    if (value is String) {
      if (value == _tomlNullSentinel) {
        return null;
      }
      if (value == _tomlEscapedNullSentinel) {
        return _tomlNullSentinel;
      }
      return value;
    }

    if (value is Map) {
      Map<String, dynamic> out = <String, dynamic>{};
      value.forEach((dynamic key, dynamic nestedValue) {
        out[key.toString()] = _fromTomlSafeValue(nestedValue);
      });
      return out;
    }

    if (value is List) {
      return value.map(_fromTomlSafeValue).toList();
    }

    return value;
  }
}

class ArtifactSecurityUtil {
  static Map<String, dynamic> s(Map<String, dynamic> data, String? cipher) {
    if (cipher == null || cipher.isEmpty) {
      throw Exception("\$artifactCipher is undefined! cannot decompress json!");
    }

    return decompressDecryptJson(
      data,
      encryptionKey: cipher,
      ignoreWarnings: true,
      keepUnknownKeys: true,
    );
  }

  static Map<String, dynamic> q(
    Map<String, dynamic> data,
    List<String>? retain,
    String? cipher,
  ) {
    if (retain == null) {
      return data;
    }

    if (cipher == null || cipher.isEmpty) {
      throw Exception("\$artifactCipher is undefined! cannot compress json!");
    }

    return compressEncryptJson(
      data,
      encryptionKey: cipher,
      retainer: retain.isEmpty ? null : (k, v) => retain.contains(k),
    );
  }
}

class PropertiesConverter {
  static String toProperties(Map<String, dynamic> map) {
    List<String> lines = <String>[];
    _serialize(map, '', lines);
    return lines.join('\n');
  }

  static void _serialize(dynamic object, String prefix, List<String> lines) {
    if (object is Map<String, dynamic>) {
      object.forEach((key, value) {
        String newPrefix = prefix.isEmpty ? key : '$prefix.$key';
        _serialize(value, newPrefix, lines);
      });
      return;
    }

    if (object is List<dynamic>) {
      for (int i = 0; i < object.length; i++) {
        String newPrefix = prefix.isEmpty ? '$i' : '$prefix.$i';
        _serialize(object[i], newPrefix, lines);
      }
      return;
    }

    String valueString;
    if (object is String) {
      valueString = '"${object.replaceAll('"', '\\"')}"';
    } else if (object is num) {
      valueString = object.toString();
    } else if (object is bool) {
      valueString = object.toString().toLowerCase();
    } else {
      valueString = object.toString();
    }

    lines.add('$prefix=$valueString');
  }

  static Map<String, dynamic> fromProperties(String input) {
    Map<String, dynamic> root = <String, dynamic>{};
    List<String> lines =
        input
            .split('\n')
            .map((line) => line.trim())
            .where((line) => line.isNotEmpty)
            .toList();

    for (String line in lines) {
      int eqIdx = line.indexOf('=');
      if (eqIdx == -1) {
        continue;
      }

      String path = line.substring(0, eqIdx).trim();
      String valueString = line.substring(eqIdx + 1);
      dynamic value = _parseValue(valueString);
      List<String> segments = path.split('.');
      _setByPath(root, segments, value);
    }

    return root;
  }

  static dynamic _parseValue(String valueString) {
    valueString = valueString.trim();
    if (valueString.startsWith('"') && valueString.endsWith('"')) {
      return valueString
          .substring(1, valueString.length - 1)
          .replaceAll('\\"', '"');
    }

    int? intValue = int.tryParse(valueString);
    if (intValue != null) {
      return intValue;
    }

    double? doubleValue = double.tryParse(valueString);
    if (doubleValue != null) {
      return doubleValue;
    }

    if (valueString.toLowerCase() == 'true') {
      return true;
    }

    if (valueString.toLowerCase() == 'false') {
      return false;
    }

    return valueString;
  }

  static void _setByPath(
    Map<String, dynamic> root,
    List<String> segments,
    dynamic value,
  ) {
    if (segments.isEmpty) {
      return;
    }

    dynamic current = root;
    for (int i = 0; i < segments.length; i++) {
      bool isLast = i == segments.length - 1;
      String segment = segments[i];
      int? index = int.tryParse(segment);
      bool isIndex = index != null;

      if (isLast) {
        if (current is Map<String, dynamic> && !isIndex) {
          current[segment] = value;
        } else if (current is List<dynamic> && isIndex) {
          while (current.length <= index) {
            current.add(null);
          }
          current[index] = value;
        } else {
          throw Exception(
            'Type mismatch at path ${segments.sublist(0, i + 1).join('.')}',
          );
        }
        continue;
      }

      String nextSegment = segments[i + 1];
      int? nextIndex = int.tryParse(nextSegment);
      bool nextIsIndex = nextIndex != null;
      if (current is Map<String, dynamic>) {
        if (isIndex) {
          throw Exception(
            'Index on map at ${segments.sublist(0, i).join('.')}',
          );
        }
        current = current.putIfAbsent(
          segment,
          () => nextIsIndex ? <dynamic>[] : <String, dynamic>{},
        );
      } else if (current is List<dynamic>) {
        if (!isIndex) {
          throw Exception(
            'String key on list at ${segments.sublist(0, i).join('.')}',
          );
        }
        while (current.length <= index) {
          current.add(null);
        }
        if (current[index] == null) {
          current[index] = nextIsIndex ? <dynamic>[] : <String, dynamic>{};
        }
        current = current[index];
      } else {
        throw Exception(
          'Invalid container at ${segments.sublist(0, i).join('.')}',
        );
      }
    }
  }
}
