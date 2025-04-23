// GENERATED – do not modify by hand

import "package:example/example.dart";
import "package:artifact/artifact.dart";
import "dart:core";
typedef _0 = ArtifactCodecUtil;
typedef _1 = Map<String, dynamic>;
typedef _2 = String;
typedef _3 = int;
typedef _4 = double;
typedef _5 = bool;
typedef _6 = Duration;
typedef _7 = DateTime;
typedef _8 = AllFields;
typedef _9 = Animal;
typedef _a = Dog;
typedef _b = Cat;
typedef _c = World;
extension $AllFields on _8 {
  _8 get _t => this;
  _1 toMap() => {
    'aString':  _0.ea(aString),
    'anString':  _0.ea(anString),
    'anrString':  _0.ea(anrString),
    'aInt':  _0.ea(aInt),
    'aDouble':  _0.ea(aDouble),
    'aBool':  _0.ea(aBool),
    'aDateTime':  _0.ea(aDateTime),
    'aDuration':  _0.ea(aDuration),
  };
  static AllFields fromMap(Map<String, dynamic> map) {
    return AllFields(
      aString: map.$c('aString') ?  _0.da(map['aString'], String) as _2 : "",
      anString: map.$c('anString') ?  _0.da(map['anString'], String) as _2 : null,
      anrString: map.$c('anrString') ?  _0.da(map['anrString'], String) as _2 : "",
      aInt: map.$c('aInt') ?  _0.da(map['aInt'], int) as _3 : 0,
      aDouble: map.$c('aDouble') ?  _0.da(map['aDouble'], double) as _4 : 0.0,
      aBool: map.$c('aBool') ?  _0.da(map['aBool'], bool) as _5 : false,
      aDateTime: map.$c('aDateTime') ?  _0.da(map['aDateTime'], DateTime) as _7 : (throw ArgumentError('Missing required AllFields."aDateTime" in map $map.')),
      aDuration: map.$c('aDuration') ?  _0.da(map['aDuration'], Duration) as _6 : const Duration(),
    );
  }
  AllFields copyWith({
    _2? aString,
    bool resetAString = false,
    String? anString,
    bool deleteAnString = false,
    String? anrString,
    bool deleteAnrString = false,
    bool resetAnrString = false,
    _3? aInt,
    bool resetAInt = false,
    _4? aDouble,
    bool resetADouble = false,
    _5? aBool,
    bool resetABool = false,
    _7? aDateTime,
    _6? aDuration,
    bool resetADuration = false,
  }) 
    => AllFields(
      aString: resetAString ? "" : (aString ?? _t.aString),
      anString: deleteAnString ? null : (anString ?? _t.anString),
      anrString: deleteAnrString ? null : resetAnrString ? "" : (anrString ?? _t.anrString),
      aInt: resetAInt ? 0 : (aInt ?? _t.aInt),
      aDouble: resetADouble ? 0.0 : (aDouble ?? _t.aDouble),
      aBool: resetABool ? false : (aBool ?? _t.aBool),
      aDateTime: aDateTime ?? _t.aDateTime,
      aDuration: resetADuration ? const Duration() : (aDuration ?? _t.aDuration),
    );
  AllFields withAString(_2 v) => copyWith(aString:v);
  AllFields resetAString() => copyWith(resetAString: true);
  AllFields withAnString(_2 v) => copyWith(anString:v);
  AllFields deleteAnString() => copyWith(deleteAnString: true);
  AllFields withAnrString(_2 v) => copyWith(anrString:v);
  AllFields deleteAnrString() => copyWith(deleteAnrString: true);
  AllFields resetAnrString() => copyWith(resetAnrString: true);
  AllFields withAInt(_3 v) => copyWith(aInt:v);
  AllFields resetAInt() => copyWith(resetAInt: true);
  AllFields incrementAInt(_3 v) => copyWith(aInt:aInt+v);
  AllFields decrementAInt(_3 v) => copyWith(aInt:aInt-v);
  AllFields withADouble(_4 v) => copyWith(aDouble:v);
  AllFields resetADouble() => copyWith(resetADouble: true);
  AllFields incrementADouble(_4 v) => copyWith(aDouble:aDouble+v);
  AllFields decrementADouble(_4 v) => copyWith(aDouble:aDouble-v);
  AllFields withABool(_5 v) => copyWith(aBool:v);
  AllFields resetABool() => copyWith(resetABool: true);
  AllFields withADateTime(_7 v) => copyWith(aDateTime:v);
  AllFields withADuration(_6 v) => copyWith(aDuration:v);
  AllFields resetADuration() => copyWith(resetADuration: true);

}
extension $Animal on _9 {
  _9 get _t => this;
  _1 toMap() => {
    'hp':  _0.ea(hp),
  };
  static Animal fromMap(Map<String, dynamic> map) {
    if (map.$c('_subclass_Animal')) {
      String sub = map['_subclass_Animal'] as String;
      switch (sub) {
        case 'Dog':
          return $Dog.fromMap(map);
        case 'Cat':
          return $Cat.fromMap(map);
      }
    }
    return Animal(
      hp: map.$c('hp') ?  _0.da(map['hp'], double) as _4 : 100,
    );
  }
  Animal copyWith({
    _4? hp,
    bool resetHp = false,
  }) 
    => Animal(
      hp: resetHp ? 100 : (hp ?? _t.hp),
    );
  Animal withHp(_4 v) => copyWith(hp:v);
  Animal resetHp() => copyWith(resetHp: true);
  Animal incrementHp(_4 v) => copyWith(hp:hp+v);
  Animal decrementHp(_4 v) => copyWith(hp:hp-v);

}
extension $Dog on _a {
  _a get _t => this;
  _1 toMap() => {
    '_subclass_Animal': 'Dog',
    'hp':  _0.ea(hp),
    'owned':  _0.ea(owned),
    'allFields':  allFields.map((e) =>  e.toMap()).toList(),
  };
  static Dog fromMap(Map<String, dynamic> map) {
    return Dog(
      hp: map.$c('hp') ?  _0.da(map['hp'], double) as _4 : 120,
      owned: map.$c('owned') ?  _0.da(map['owned'], bool) as _5 : false,
      allFields: map.$c('allFields') ?  (map['allFields'] as List).map((e) =>  $AllFields.fromMap((e) as _1)).toList() : const [],
    );
  }
  Dog copyWith({
    _4? hp,
    bool resetHp = false,
    _5? owned,
    bool resetOwned = false,
    List<AllFields>? allFields,
    bool resetAllFields = false,
  }) 
    => Dog(
      hp: resetHp ? 120 : (hp ?? _t.hp),
      owned: resetOwned ? false : (owned ?? _t.owned),
      allFields: resetAllFields ? const [] : (allFields ?? _t.allFields),
    );
  Dog withHp(_4 v) => copyWith(hp:v);
  Dog resetHp() => copyWith(resetHp: true);
  Dog incrementHp(_4 v) => copyWith(hp:hp+v);
  Dog decrementHp(_4 v) => copyWith(hp:hp-v);
  Dog withOwned(_5 v) => copyWith(owned:v);
  Dog resetOwned() => copyWith(resetOwned: true);
  Dog withAllFields(List<AllFields> v) => copyWith(allFields:v);
  Dog resetAllFields() => copyWith(resetAllFields: true);

}
extension $Cat on _b {
  _b get _t => this;
  _1 toMap() => {
    '_subclass_Animal': 'Cat',
    'hp':  _0.ea(hp),
    'lives':  _0.ea(lives),
  };
  static Cat fromMap(Map<String, dynamic> map) {
    return Cat(
      hp: map.$c('hp') ?  _0.da(map['hp'], double) as _4 : 70,
      lives: map.$c('lives') ?  _0.da(map['lives'], int) as _3 : 9,
    );
  }
  Cat copyWith({
    _4? hp,
    bool resetHp = false,
    _3? lives,
    bool resetLives = false,
  }) 
    => Cat(
      hp: resetHp ? 70 : (hp ?? _t.hp),
      lives: resetLives ? 9 : (lives ?? _t.lives),
    );
  Cat withHp(_4 v) => copyWith(hp:v);
  Cat resetHp() => copyWith(resetHp: true);
  Cat incrementHp(_4 v) => copyWith(hp:hp+v);
  Cat decrementHp(_4 v) => copyWith(hp:hp-v);
  Cat withLives(_3 v) => copyWith(lives:v);
  Cat resetLives() => copyWith(resetLives: true);
  Cat incrementLives(_3 v) => copyWith(lives:lives+v);
  Cat decrementLives(_3 v) => copyWith(lives:lives-v);

}
extension $World on _c {
  _c get _t => this;
  _1 toMap() => {
    'animals':  animals.map((e) =>  e.toMap()).toList(),
  };
  static World fromMap(Map<String, dynamic> map) {
    return World(
      animals: map.$c('animals') ?  (map['animals'] as List).map((e) =>  $Animal.fromMap((e) as _1)).toList() : const [],
    );
  }
  World copyWith({
    List<Animal>? animals,
    bool resetAnimals = false,
  }) 
    => World(
      animals: resetAnimals ? const [] : (animals ?? _t.animals),
    );
  World withAnimals(List<Animal> v) => copyWith(animals:v);
  World resetAnimals() => copyWith(resetAnimals: true);

}

