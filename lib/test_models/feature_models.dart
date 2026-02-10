import 'package:artifact/artifact.dart';

const Artifact plainArtifact = Artifact(compression: false);
const Artifact reflectArtifact = Artifact(compression: false, reflection: true);
const Artifact schemaArtifact = Artifact(
  compression: false,
  generateSchema: true,
);

enum Mood { happy, sad }

enum UiHint { title, subtitle, classLevel }

class Weird {
  final int value;

  const Weird(this.value);
}

class WeirdCodec extends ArtifactCodec<int, Weird> {
  const WeirdCodec();

  @override
  Weird? decode(int? value) => value == null ? null : Weird(value);

  @override
  int? encode(Weird? value) => value?.value;
}

@reflectArtifact
@attach(UiHint.classLevel)
class Person {
  @attach(UiHint.title)
  final String name;

  @attach(UiHint.subtitle)
  final String? subtitle;

  const Person({required this.name, this.subtitle});
}

@plainArtifact
class Animal {
  final int hp;

  const Animal({this.hp = 10});
}

@plainArtifact
class Dog extends Animal {
  final bool goodBoy;

  const Dog({super.hp = 20, this.goodBoy = true});
}

@plainArtifact
class Zoo {
  final List<Animal> animals;

  const Zoo({this.animals = const []});
}

int receivedPingEvents = 0;

class PingEvent {}

@reflectArtifact
class ListenerModel {
  final int id;

  const ListenerModel({this.id = 0});

  @eventHandler
  void onPing(PingEvent event) {
    receivedPingEvents += 1;
  }
}

@plainArtifact
class FeatureModel {
  @rename('v')
  final int value;

  final double ratio;

  final String? note;

  final List<int> numbers;

  final Set<String> tags;

  final Mood mood;

  @codec(WeirdCodec())
  final Weird weird;

  const FeatureModel({
    this.value = 4,
    required this.ratio,
    this.note,
    this.numbers = const <int>[],
    this.tags = const <String>{},
    this.mood = Mood.happy,
    this.weird = const Weird(7),
  });
}

@reflectArtifact
class ReflectModel {
  final int value;

  const ReflectModel({this.value = 1});
}

@reflectArtifact
class NullableReflectSubObject {
  final String value;
  final int anotherValue;

  const NullableReflectSubObject({
    this.value = "something",
    this.anotherValue = 42,
  });
}

@reflectArtifact
class NullableReflectCollectionsModel {
  final List<String?> aListOfNullableStrings;
  final Set<String?> aSetOfNullableStrings;
  final List<NullableReflectSubObject?> aListOfNullableSubObjects;
  final Set<NullableReflectSubObject?> aSetOfNullableSubObjects;
  final Map<String, String?> aMapOfStringToNullableString;
  final Map<String, NullableReflectSubObject?> aMapOfStringToNullableSubObject;

  const NullableReflectCollectionsModel({
    this.aListOfNullableStrings = const <String?>[],
    this.aSetOfNullableStrings = const <String?>{},
    this.aListOfNullableSubObjects = const <NullableReflectSubObject?>[],
    this.aSetOfNullableSubObjects = const <NullableReflectSubObject?>{},
    this.aMapOfStringToNullableString = const <String, String?>{},
    this.aMapOfStringToNullableSubObject =
        const <String, NullableReflectSubObject?>{},
  });
}

@schemaArtifact
class SchemaModel {
  @rename('identifier')
  final int id;

  @describe('Enabled flag')
  final bool enabled;

  final List<int> samples;

  const SchemaModel({
    this.id = 1,
    this.enabled = true,
    this.samples = const <int>[1, 2],
  });
}
