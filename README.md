// Artifact

[![Pub](https://img.shields.io/pub/v/artifact.svg)](https://pub.dev/packages/artifact)

Map Dart objects to maps, JSON, YAML, TOML, XML, or properties files effortlessly! No part files, no manual boilerplate, no extending or mixing in nonexistent classes—just slap the `@Artifact` annotation on any class, run the code generator, and get automatic extension methods for serialization, deserialization, immutability with `copyWith`, and more.

The beauty of Artifact lies in its simplicity: annotate your immutable classes, and the generator creates everything you need. Deserialization is as easy as `$YourClass.fromMap(map)`, returning an instance of `YourClass`. Supports inheritance, collections, enums, custom field renaming, and even attachments for metadata like UI components.

## Project Manifest

For a file-by-file architecture and feature map, see [MANIFEST.md](MANIFEST.md).

## Features

- **Zero Boilerplate**: Just `@Artifact`—no part files or manual implementations.
- **Multi-Format Support**: Serialize to JSON, YAML, TOML, XML, or properties.
- **Inheritance**: Automatic subclass handling with `_subclass_` markers in maps.
- **Collections**: Full support for `List`, `Set`, `Map` (including nested artifacts).
- **Enums**: Serialized by name, deserialized by value.
- **CopyWith**: Immutable updates with deltas for numerics, append/remove for collections.
- **Attachments**: Annotate fields with custom metadata (e.g., UI hints) and retrieve via `getAttachment`.
- **Options**: Compression for smaller output, reflection for runtime introspection, schema generation.
- **Type Safety**: Explicit typing, null safety, and error handling for missing required fields.
- **Exporting**: You can auto export files to an exports.gen.dart with controls

Because artifact is generating extension methods, certain class ops are not possible such as: 

- Read-only fields
- JSON templates that are NOT object
- Getter properties
- Private fields

## Setup

Add the runtime dependency:

```bash
flutter pub add artifact
```

Add the code generator and builder:

```bash
flutter pub add artifact_gen build_runner --dev
```

Run the generator:

```bash
dart run build_runner build
```

This generates `lib/gen/artifacts.gen.dart` with extensions for your annotated classes. Import it in your code: `import 'gen/artifacts.gen.dart';`.

For watch mode during development:

```bash
dart run build_runner watch
```

## Basic Usage

Annotate your immutable class with `@Artifact`. Fields must be `final` and use a `const` constructor with named parameters.

```dart
import 'package:artifact/artifact.dart';
import 'gen/artifacts.gen.dart'; // Generated

@artifact // That's it!
class Animal {
  @rename("hp") // Optional: custom map key
  final int health;
  final String? nonSerializable; // Ignored in serialization
  
  // The constructor defines what is serialized!
  const Animal({this.health = 100});
}
```

### Serialization

```dart
Animal dog = const Animal(health: 125);

String json = dog.toJson(); // Or toYaml(), toToml(), toXml(), toProperties()
Map<String, dynamic> map = dog.toMap();

print(json); // {"hp": 125}
```

### Deserialization

Use the generated extension:

```dart
Map<String, dynamic> data = {"hp": 125};
Animal animal = $Animal.fromMap(data); // Returns Animal instance

// Handles defaults and required fields (throws if missing required)
Animal cat = $Cat.fromMap({"hp": 70, "lives": 9}); // For subclasses
```

## Inheritance

Subclasses are automatically handled. The generated map includes a `_subclass_BaseClass` key for polymorphic deserialization.

```dart
@artifact
class Dog extends Animal {
  final bool goodBoy;

  const Dog({
    super.health = 125,
    this.goodBoy = true,
  });
}

@artifact
class Cat extends Animal {
  final int lives;

  const Cat({
    super.health = 70,
    this.lives = 9,
  });
}

@artifact
class World {
  final List<Animal> animals; // Polymorphic list

  const World({this.animals = const []});
}
```

Usage:

```dart
World world = World(
  animals: [
    const Dog(goodBoy: true),
    const Cat(lives: 8, health: 50),
  ],
);

print(world.toJson(pretty: true));
```

Output:

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

Deserialization reconstructs the correct subclass:

```dart
World fromWorld = $World.fromMap(worldMap);
Animal first = fromWorld.animals.first; // Dog instance
```

## Collections and Enums

Supports nested artifacts, primitives, and collections. Enums serialize by name.

```dart
enum Mood { happy, sad }

@artifact
class Pet {
  final String name;
  final Mood mood;
  final List<Animal> friends;
  final Set<String> tags;
  @rename("data")
  final Map<String, int> metadata;

  const Pet({
    required this.name,
    required this.mood,
    required this.friends,
    this.tags = const {},
    this.metadata = const {},
  });
}
```

Serialization handles nesting and collections automatically.

## Immutability with CopyWith

Generated `copyWith` supports resets, direct values, and deltas (for numerics). Collections support append/remove.

```dart
Animal dog = const Dog(health: 100, goodBoy: true);

// Add health, toggle goodBoy
Animal updated = dog.copyWith(deltaHealth: 25, goodBoy: false);

// Reset health to default
Animal reset = dog.copyWith(resetHealth: true);

// For lists/sets
World updatedWorld = world.copyWith(
  appendAnimals: [newCat],
  removeTags: {'oldTag'},
);
```

## Attachments

Attach constant metadata to classes or fields for runtime retrieval (e.g., UI hints).

First, define attachment types:

```dart
enum UIType { title, subtitle }

class UITitle extends Attachment {
  const UITitle([super.data = UIType.title]);
}

const uiTitle = UITitle();
const uiSubtitle = UISubtitle();
```

Annotate:

```dart
@Artifact
@attach(uiTitle) // Class-level
class Person {
  @uiTitle
  final String name;

  @uiSubtitle
  final String email;

  const Person({required this.name, required this.email});
}
```

Retrieve:

```dart
Person person = const Person(name: "Alice", email: "alice@example.com");

// Field attachment
String title = person.getAttachment<UIType, String>(UIType.title); // "Alice"

// Class attachment
List<dynamic> allAttachments = $Person.rootAttachments;
```

## Advanced Options

Customize via `@Artifact` parameters:

```dart
@Artifact(
  compression: true, // Minify generated code (default: true)
  reflection: true,  // Generate runtime introspection (e.g., $fields)
  generateSchema: true, // Generate JSON schema
)
class MyClass { ... }
```

- **Reflection**: Access fields via `$MyClass.$fields` (List of field descriptors).
- **Schema**: Generates `$MyClass.schema` for validation.

Custom codecs via `@codec`:

```dart
@codec(MyCustomCodec())
class MyClass { ... }
```

## Generated API

For each `@Artifact` class `MyClass`, the generator creates an extension `$MyClass`:

- **Serialization**: `toJson([pretty])`, `toYaml()`, `toToml()`, `toXml([pretty])`, `toProperties()`, `toMap()`.
- **Deserialization**: `static MyClass fromJson(String)`, `fromYaml(String)`, etc., `fromMap(Map<String, dynamic>)`.
- **Immutability**: `copyWith({params})` with deltas/append/remove.
- **Helpers**: `static MyClass newInstance` (defaults), `$fields` (if reflection), `schema` (if generateSchema).
- **Global**: `$isArtifact(obj)`, `$constructArtifact<MyClass>()`, `$artifactToMap(obj)`, `$artifactFromMap<MyClass>(map)`.

## Example

See `example/lib/example.dart` for a full demo with strings, ints, enums, subclasses, lists, sets, and maps. Run:

```bash
cd example
dart run build_runner build
dart run
```

Output demonstrates construction, serialization, and type checks.

## How It Works

The `artifact_gen` builder scans for `@Artifact` classes, analyzes fields/constructors/inheritance, and generates type-safe extensions. Supports null safety, required fields (throws on missing), defaults, and compression for concise code.

No runtime reflection—pure code generation for performance.

## Auto Exporting

To just export everything add an `artifact` block to your `pubspec.yaml`

```yaml
name: my_package
version: 1.0.0

artifact: 
  # Use this to auto export all generated files to exports.gen.dart
  export: true
```

If you dont define export: true, it assumes false, however you can still fine tune exports with `@external` and `@internal` annotations.

File: `lib/a.dart`
```dart
@internal
String coreValue = "something";

@external
class SomeCommonClass {}
```

and `lib/b.dart`
```dart
@internal
class AnotherClass {}

@external
class SomeOtherClass {}

@internal
int add(int a, int b) {
  return a + b;
}
```

Assuming `artifact: export: true`, the export file `lib/exports.gen.dart` will contain

```dart
export 'package:example/b.dart' show SomeOtherClass;
export 'package:example/a.dart' show SomeCommonClass;
```

Then to complete setup just add `export 'gen/exports.gen.dart';` to your `my_package.dart` file.

## Limitations

- Only serializes fields defined in the constructor.
- Polymorphism requires all subclasses annotated.
- Custom types need manual codec registration if not primitives/artifacts/enums.

## Interesting Notes
- You can mark your existing dart_mappable / freezed / json_serializable classes with @artifact to get dual functionality or for ease of migration
- Artifact actually does support mutable fields its just not recommended
- You can customize @Artifact by creating a subclass of it and define default params, then do `const Artifact art = Artifact(...);` then `@art`
