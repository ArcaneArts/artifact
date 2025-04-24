import 'package:artifact/artifact.dart';

@artifact
class Animal {
  final int health;

  const Animal({@rename("hp") required this.health});
}

@artifact
class Dog extends Animal {
  final bool goodBoy;

  const Dog({required this.goodBoy, required super.health});
}

void main() {}
