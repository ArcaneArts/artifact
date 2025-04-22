// GENERATED – do not modify by hand

import "dart:core";

import "package:example/example.dart";

extension $Animal on Animal {
  Map<String, dynamic> toMap() => <String, dynamic>{'hp': hp};

  static Animal fromMap(Map<String, dynamic> map) {
    if (map.containsKey('_subclass_Animal')) {
      String sub = map['_subclass_Animal'] as String;

      switch (sub) {
        case 'Dog':
          return $Dog.fromMap(map);
        case 'Cat':
          return $Cat.fromMap(map);
      }
    }
    return Animal(hp: map.containsKey('hp') ? map['hp'] : 100);
  }

  Animal copyWith({double? hp}) => Animal(hp: hp ?? this.hp);
}

extension $Dog on Dog {
  Map<String, dynamic> toMap() => <String, dynamic>{
    '_subclass_Animal': 'Dog',
    'hp': hp,
    'owned': owned,
  };

  static Dog fromMap(Map<String, dynamic> map) {
    return Dog(
      hp: map.containsKey('hp') ? map['hp'] : 120,
      owned: map.containsKey('owned') ? map['owned'] : false,
    );
  }

  Dog copyWith({double? hp, bool? owned}) =>
      Dog(hp: hp ?? this.hp, owned: owned ?? this.owned);
}

extension $Cat on Cat {
  Map<String, dynamic> toMap() => <String, dynamic>{
    '_subclass_Animal': 'Cat',
    'hp': hp,
    'lives': lives,
  };

  static Cat fromMap(Map<String, dynamic> map) {
    return Cat(
      hp: map.containsKey('hp') ? map['hp'] : 70,
      lives: map.containsKey('lives') ? map['lives'] : 9,
    );
  }

  Cat copyWith({double? hp, int? lives}) =>
      Cat(hp: hp ?? this.hp, lives: lives ?? this.lives);
}

extension $World on World {
  Map<String, dynamic> toMap() => <String, dynamic>{
    'animals': animals.map((e) => e.toMap()).toList(),
  };

  static World fromMap(Map<String, dynamic> map) {
    return World(
      animals:
          map.containsKey('animals')
              ? (map['animals'] as List)
                  .map((e) => $Animal.fromMap((e) as Map<String, dynamic>))
                  .toList()
              : const [],
    );
  }

  World copyWith({List<Animal>? animals}) =>
      World(animals: animals ?? this.animals);
}
