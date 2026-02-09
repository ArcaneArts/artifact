import 'package:artifact/artifact.dart';
import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

void main() {
  test('from_map deserializes rename codec enum and collections', () {
    Map<String, dynamic> map = <String, dynamic>{
      'v': 9,
      'ratio': 2.5,
      'note': 'hello',
      'numbers': <int>[3, 4],
      'tags': <String>['left', 'right'],
      'mood': 'sad',
      'weird': 88,
    };

    FeatureModel model = $FeatureModel.fromMap(map);

    expect(model.value, 9);
    expect(model.ratio, 2.5);
    expect(model.note, 'hello');
    expect(model.numbers, <int>[3, 4]);
    expect(model.tags, <String>{'left', 'right'});
    expect(model.mood, Mood.sad);
    expect(model.weird.value, 88);
  });

  test('from_map uses defaults for missing optional values', () {
    Map<String, dynamic> map = <String, dynamic>{'ratio': 4.0};

    FeatureModel model = $FeatureModel.fromMap(map);

    expect(model.value, 4);
    expect(model.note, isNull);
    expect(model.numbers, const <int>[]);
    expect(model.tags, const <String>{});
    expect(model.mood, Mood.happy);
    expect(model.weird.value, 7);
  });

  test('from_map throws when required field is missing', () {
    Map<String, dynamic> map = <String, dynamic>{'v': 10};

    expect(() => $FeatureModel.fromMap(map), throwsArgumentError);
  });

  test('from_map resolves subclass marker for inherited artifacts', () {
    Map<String, dynamic> map = <String, dynamic>{
      '_subclass_Animal': 'Dog',
      'hp': 34,
      'goodBoy': false,
    };

    Animal animal = $Animal.fromMap(map);

    expect(animal, isA<Dog>());
    expect((animal as Dog).hp, 34);
    expect(animal.goodBoy, isFalse);
  });

  test('from importer decodes json yaml toml props and toon', () {
    String json = '{"ratio": 5.5, "v": 2, "mood": "sad", "weird": 12}';
    String yaml = 'ratio: 5.5\nv: 2\nmood: sad\nweird: 12\n';
    String toml = 'ratio = 5.5\nv = 2\nmood = "sad"\nweird = 12\n';
    String props = 'ratio=5.5\nv=2\nmood="sad"\nweird=12';
    FeatureModel source = FeatureModel(
      value: 2,
      ratio: 5.5,
      mood: Mood.sad,
      weird: const Weird(12),
    );
    String toon = source.to.toon;

    FeatureModel fromJson = $FeatureModel.from.json(json);
    FeatureModel fromYaml = $FeatureModel.from.yaml(yaml);
    FeatureModel fromToml = $FeatureModel.from.toml(toml);
    FeatureModel fromProps = $FeatureModel.from.props(props);
    FeatureModel fromToon = $FeatureModel.from.toon(toon);

    expect(fromJson.ratio, 5.5);
    expect(fromYaml.value, 2);
    expect(fromToml.mood, Mood.sad);
    expect(fromProps.weird.value, 12);
    expect(fromToon.value, 2);
  });
}
