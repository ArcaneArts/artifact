Map objects to maps or json without part files or any nonsense! Just an annotation!

```
flutter pub add artifact
flutter pub add artifact_gen --dev
```

```dart
import 'package:artifact/artifact.dart';
```

```dart
@artifact // Artifact is all you need!
class Animal {
  @rename("hp")
  final int health;
  String? someNonSerializableField;
  
  // Parameters define what is mapped
  // Default values are used if not set
  // Required parameters will throw if not set
  const Animal({this.health = 100});
}
```

Let's add two subclasses for animals
```dart
@artifact
class Dog extends Animal {
  final bool goodBoy;

  const Dog({@rename("hp") super.health = 125, this.goodBoy = true});
}
```

```dart
@artifact
class Cat extends Animal {
  final int lives;
  
  const Cat({@rename("hp") super.health = 70, this.lives = 9});
}
```

Lets put this in a world object

```dart
@artifact
class World {
  final List<Animal> animals;
  
  const World({this.animals = const []});
}
```

Then use it!

```dart
World world = World(
  animals: [
    Dog(goodBoy: true),
    Cat(lives: 8, health: 50),
  ]
);

print(jsonEncode(world.toMap()));
```

```json
{
  "animals": [
    {
      "_subclass_Animal": "Dog",
      "hp": 125,
      "goodBoy": true
    },
    {
      "_subclass_Animal": "Cat",
      "hp": 50,
      "lives": 8
    }
  ]
}
```

CopyWith also exists since artifacts are immutable

You deserialize with the generated extension
```dart
$Animal.fromMap(...);
```

