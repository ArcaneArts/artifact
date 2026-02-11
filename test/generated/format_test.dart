import 'dart:convert';

import 'package:artifact/artifact.dart';
import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

FeatureModel _buildModel() {
  return FeatureModel(
    value: 8,
    ratio: 1.5,
    note: 'hello',
    numbers: const <int>[1, 2, 3],
    tags: const <String>{'alpha'},
    mood: Mood.sad,
    weird: const Weird(42),
  );
}

Map<String, dynamic> _normalizeMap(Map<dynamic, dynamic> value) {
  Map<String, dynamic> out = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry in value.entries) {
    String key = entry.key.toString();
    out[key] = _normalizeValue(entry.value);
  }
  return out;
}

dynamic _normalizeValue(dynamic value) {
  if (value is Map) {
    Map<dynamic, dynamic> map = Map<dynamic, dynamic>.from(value);
    return _normalizeMap(map);
  }

  if (value is Iterable) {
    List<dynamic> out = <dynamic>[];
    for (dynamic entry in value) {
      out.add(_normalizeValue(entry));
    }
    return out;
  }

  return value;
}

void main() {
  test('yaml format matches toMap data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());
    YamlMap yamlObject = loadYaml(model.to.yaml) as YamlMap;
    Map<String, dynamic> actual = _normalizeMap(
      Map<dynamic, dynamic>.from(yamlObject),
    );

    expect(actual, expected);
  });

  test('yaml importer handles nested maps without YamlMap casts', () {
    NullableReflectCollectionsModel model = NullableReflectCollectionsModel(
      aListOfNullableSubObjects: const <NullableReflectSubObject?>[
        NullableReflectSubObject(value: 'one', anotherValue: 1),
      ],
      aMapOfStringToNullableSubObject:
          const <String, NullableReflectSubObject?>{
            'left': NullableReflectSubObject(value: 'two', anotherValue: 2),
          },
    );

    String yaml = model.to.yaml;
    NullableReflectCollectionsModel decoded = $NullableReflectCollectionsModel
        .from
        .yaml(yaml);

    expect(decoded.aListOfNullableSubObjects.length, 1);
    expect(decoded.aListOfNullableSubObjects.first?.value, 'one');
    expect(decoded.aMapOfStringToNullableSubObject['left']?.anotherValue, 2);
  });

  test('json format matches toMap data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());
    Map<dynamic, dynamic> parsed = jsonDecode(model.to.json) as Map;
    Map<String, dynamic> actual = _normalizeMap(parsed);

    expect(actual, expected);
  });

  test('jsonPretty format matches json format data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> jsonMap = _normalizeMap(
      jsonDecode(model.to.json) as Map<dynamic, dynamic>,
    );
    Map<String, dynamic> prettyMap = _normalizeMap(
      jsonDecode(model.to.jsonPretty) as Map<dynamic, dynamic>,
    );

    expect(prettyMap, jsonMap);
  });

  test('toml format matches toMap data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());
    Map<String, dynamic> parsed = ArtifactDataUtil.t(model.to.toml);
    Map<String, dynamic> actual = _normalizeMap(parsed);

    expect(actual, expected);
  });

  test('toml round-trip preserves nullable scalar fields', () {
    FeatureModel model = FeatureModel(
      ratio: 7.5,
      note: null,
      numbers: const <int>[4, 5],
      tags: const <String>{'tag'},
      mood: Mood.happy,
      weird: const Weird(9),
    );

    String toml = model.to.toml;
    FeatureModel decoded = $FeatureModel.from.toml(toml);

    expect(decoded.note, isNull);
    expect(decoded.ratio, 7.5);
    expect(decoded.numbers, const <int>[4, 5]);
  });

  test('toml round-trip preserves nullable collection entries', () {
    NullableReflectCollectionsModel model = NullableReflectCollectionsModel(
      aListOfNullableStrings: const <String?>['left', null, 'right'],
      aSetOfNullableStrings: const <String?>{'alpha', null},
      aMapOfStringToNullableString: const <String, String?>{
        'present': 'value',
        'missing': null,
      },
    );

    String toml = model.to.toml;
    NullableReflectCollectionsModel decoded = $NullableReflectCollectionsModel
        .from
        .toml(toml);

    expect(decoded.aListOfNullableStrings, const <String?>[
      'left',
      null,
      'right',
    ]);
    expect(decoded.aSetOfNullableStrings.contains('alpha'), isTrue);
    expect(decoded.aSetOfNullableStrings.contains(null), isTrue);
    expect(decoded.aMapOfStringToNullableString['present'], 'value');
    expect(decoded.aMapOfStringToNullableString['missing'], isNull);
  });

  test('toon format matches toMap data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());
    Map<String, dynamic> parsed = ArtifactDataUtil.i(model.to.toon);
    Map<String, dynamic> actual = _normalizeMap(parsed);

    expect(actual, expected);
  });

  test('props format matches toMap data', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());
    Map<String, dynamic> parsed = ArtifactDataUtil.g(model.to.props);
    Map<String, dynamic> actual = _normalizeMap(parsed);

    expect(actual, expected);
  });

  test('from importers round-trip each text format', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());

    FeatureModel fromJson = $FeatureModel.from.json(model.to.json);
    FeatureModel fromYaml = $FeatureModel.from.yaml(model.to.yaml);
    FeatureModel fromToml = $FeatureModel.from.toml(model.to.toml);
    FeatureModel fromToon = $FeatureModel.from.toon(model.to.toon);
    FeatureModel fromProps = $FeatureModel.from.props(model.to.props);

    expect(_normalizeMap(fromJson.toMap()), expected);
    expect(_normalizeMap(fromYaml.toMap()), expected);
    expect(_normalizeMap(fromToml.toMap()), expected);
    expect(_normalizeMap(fromToon.toMap()), expected);
    expect(_normalizeMap(fromProps.toMap()), expected);
  });

  test('from importers round-trip bson formats', () {
    FeatureModel model = _buildModel();
    Map<String, dynamic> expected = _normalizeMap(model.toMap());

    FeatureModel fromBson = $FeatureModel.from.bson(model.to.bson);
    FeatureModel fromBsonCompressed = $FeatureModel.from.bson(
      model.to.bsonCompressed,
      compressed: true,
    );

    expect(_normalizeMap(fromBson.toMap()), expected);
    expect(_normalizeMap(fromBsonCompressed.toMap()), expected);
  });
}
