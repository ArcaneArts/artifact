import 'package:artifact/artifact.dart';
import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

void main() {
  test('to_map serializes rename codec enum and collections', () {
    FeatureModel model = FeatureModel(
      value: 8,
      ratio: 1.5,
      note: 'hello',
      numbers: const <int>[1, 2, 3],
      tags: const <String>{'alpha', 'beta'},
      mood: Mood.sad,
      weird: const Weird(42),
    );

    Map<String, dynamic> map = model.toMap();

    expect(map.containsKey('v'), isTrue);
    expect(map.containsKey('value'), isFalse);
    expect(map['v'], 8);
    expect(map['ratio'], 1.5);
    expect(map['note'], 'hello');
    expect(map['weird'], 42);
    expect(map['mood'], 'sad');
    expect(map['numbers'], <int>[1, 2, 3]);

    List<dynamic> tags = map['tags'] as List<dynamic>;
    expect(tags.toSet(), <String>{'alpha', 'beta'});
  });

  test('to_map emits subclass marker for polymorphic roots', () {
    Animal animal = Dog(hp: 91, goodBoy: false);

    Map<String, dynamic> map = animal.toMap();

    expect(map['_subclass_Animal'], 'Dog');
    expect(map['hp'], 91);
    expect(map['goodBoy'], isFalse);
  });

  test('to_map serializes nested artifact lists with subclass markers', () {
    Zoo zoo = Zoo(animals: const <Animal>[Dog(hp: 77, goodBoy: true)]);

    Map<String, dynamic> map = zoo.toMap();
    List<dynamic> animals = map['animals'] as List<dynamic>;
    Map<String, dynamic> first = animals.first as Map<String, dynamic>;

    expect(animals.length, 1);
    expect(first['_subclass_Animal'], 'Dog');
    expect(first['hp'], 77);
    expect(first['goodBoy'], isTrue);
  });

  test('to exporter encodes json yaml toml props and toon', () {
    FeatureModel model = FeatureModel(
      ratio: 3.25,
      note: 'text',
      numbers: const <int>[5],
      tags: const <String>{'x'},
      mood: Mood.happy,
      weird: const Weird(11),
    );

    String json = model.to.json;
    String yaml = model.to.yaml;
    String toml = model.to.toml;
    String props = model.to.props;
    String toon = model.to.toon;

    expect(json.contains('"ratio":3.25'), isTrue);
    expect(yaml.contains('ratio: 3.25'), isTrue);
    expect(toml.contains('ratio = 3.25'), isTrue);
    expect(props.contains('ratio=3.25'), isTrue);
    expect(toon.isNotEmpty, isTrue);
  });
}
