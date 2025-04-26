Map objects to maps or json without part files or any nonsense! Just an annotation!
```
flutter pub add artifact
flutter pub add artifact_gen --dev
```

Make the model class
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
Animal animal = $Animal.fromMap(...)
    // Add 10 hp
    .copyWith(deltaHp: 10);

if(animal is Cat) {
  // Add a life
  (animal as Cat).copyWith(deltaLives: 1);
}
```

## Attachments

```class
@attach("Any const object")
@artifact
class SomeModel {
    @attach(42)
    final String name;
    
    @attach(const SomeClassData())
    final int age;
    
    const SomeModel({
        this.name = "John Doe",
        this.age = 0,
    });
}
```

Then you can get via attachments
```dart
List<dynamic> all = $SomeModel.rootAttachments;

// Or get field by attachment
SomeModel m = SomeModel(name: "Dan", age: 2);

String n = m.getAttachment<int, String>(42);
// n = "Dan
```

## Custom Attachments
You can simply extend the attachment class to make it simpler to work with and utilize

```dart
// First we define a data class or enum to signal information
enum UiComponentType {
  title,
  subtitle,
}

// Then we extend annotations on attachment
class UITitle extends attachment{
  const UITitle(super.data = UiComponentType.title);
}

class UISubtitle extends attachment{
  const UIComponent(super.data = UiComponentType.subtitle);
}

// These are optional if you want to skip the ()
const uititle = UITitle();
const uisubtitle = UISubtitle();
```

Then we can use it in our models as annotations

```dart
@artifact
class Person {
  @uititle
  final String name;
  
  @uisubtitle
  final String email;
  
  const Person({required this.name, required this.email});
}
```

Now, we can use it!

```dart
List<User> users = ...

Widget build(BuildContext context) => ListView(children: [
  ...users.map((i) => ListTile(
    title: Text(i.getAttachment(UiComponentType.title)),
    subtitle: Text(i.getAttachment(UiComponentType.subtitle)),
  ))
]);
```