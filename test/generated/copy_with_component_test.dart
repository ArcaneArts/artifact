import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

void main() {
  test('copy_with supports delta reset delete append and remove', () {
    FeatureModel model = FeatureModel(
      ratio: 2.0,
      note: 'x',
      numbers: const <int>[1, 2],
      tags: const <String>{'a', 'b'},
    );

    FeatureModel updated = model.copyWith(
      deltaValue: 3,
      deltaRatio: 0.5,
      deleteNote: true,
      appendNumbers: const <int>[3],
      removeNumbers: const <int>[1],
      appendTags: const <String>{'c'},
      removeTags: const <String>{'a'},
    );

    expect(updated.value, 7);
    expect(updated.ratio, 2.5);
    expect(updated.note, isNull);
    expect(updated.numbers, <int>[2, 3]);
    expect(updated.tags, <String>{'b', 'c'});

    FeatureModel reset = updated.copyWith(
      resetValue: true,
      resetMood: true,
      resetWeird: true,
      resetNumbers: true,
      resetTags: true,
    );

    expect(reset.value, 4);
    expect(reset.mood, Mood.happy);
    expect(reset.weird.value, 7);
    expect(reset.numbers, <int>[]);
    expect(reset.tags, <String>{});
  });

  test('copy_with handles nullable delete flags', () {
    Person person = Person(name: 'Name', subtitle: 'Subtitle');

    Person removedSubtitle = person.copyWith(deleteSubtitle: true);
    Person replacedSubtitle = person.copyWith(subtitle: 'Updated');

    expect(removedSubtitle.subtitle, isNull);
    expect(replacedSubtitle.subtitle, 'Updated');
  });

  test('copy_with supports inherited model behavior', () {
    Dog dog = Dog(hp: 15, goodBoy: false);

    Dog updatedDog = dog.copyWith(deltaHp: 5, resetGoodBoy: true);

    expect(updatedDog.hp, 20);
    expect(updatedDog.goodBoy, isTrue);

    Animal polymorphic = dog;
    Animal updatedPoly = polymorphic.copyWith(deltaHp: 2);

    expect(updatedPoly, isA<Dog>());
    expect((updatedPoly as Dog).hp, 17);
  });

  test('copy_with appends resets and replaces list fields on zoo', () {
    Zoo zoo = Zoo(animals: const <Animal>[Dog(hp: 10, goodBoy: true)]);

    Zoo appended = zoo.copyWith(
      appendAnimals: const <Animal>[Dog(hp: 20, goodBoy: false)],
    );

    expect(appended.animals.length, 2);
    expect((appended.animals.first as Dog).hp, 10);

    Zoo reset = appended.copyWith(resetAnimals: true);
    Zoo replaced = appended.copyWith(
      animals: const <Animal>[Dog(hp: 33, goodBoy: false)],
    );

    expect(reset.animals, <Animal>[]);
    expect(replaced.animals.length, 1);
    expect((replaced.animals.first as Dog).hp, 33);
    expect((replaced.animals.first as Dog).goodBoy, isFalse);
  });
}
