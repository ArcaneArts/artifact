import 'package:artifact/artifact.dart';

@artifact
class Animal {
  final double hp;

  const Animal({this.hp = 100});
}

@artifact
class Dog extends Animal {
  final bool owned;

  const Dog({super.hp = 120, this.owned = false});
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
