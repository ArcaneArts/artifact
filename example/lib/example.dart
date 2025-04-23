import 'dart:convert';

import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

void main() {
  print(jsonEncode(AllFields(aDateTime: DateTime.now()).toMap()));
  print(
    jsonEncode(
      $AllFields
          .fromMap(
            jsonDecode(
              jsonEncode(AllFields(aDateTime: DateTime.now()).toMap()),
            ),
          )
          .toMap(),
    ),
  );
}

@artifact
class AllFields {
  final String aString;
  final String? anString;
  final String? anrString;
  final int aInt;
  final double aDouble;
  final bool aBool;
  final DateTime aDateTime;
  final Duration aDuration;

  const AllFields({
    this.aString = "",
    this.anString,
    this.anrString = "",
    this.aInt = 0,
    this.aDouble = 0.0,
    this.aBool = false,
    required this.aDateTime,
    this.aDuration = const Duration(),
  });
}

@artifact
class Animal {
  final double hp;

  const Animal({this.hp = 100});
}

@artifact
class Dog extends Animal {
  final bool owned;
  final List<AllFields> allFields;

  const Dog({super.hp = 120, this.owned = false, this.allFields = const []});
}

@artifact
class Cat extends Animal {
  final int lives;

  const Cat({super.hp = 70, this.lives = 9});
}

@artifact
class World {
  final List<Animal> animals;

  const World({this.animals = const []});
}
