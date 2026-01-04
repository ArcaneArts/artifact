import 'package:artifact/artifact.dart';

// ============================================================================
// Basic Models
// ============================================================================

@artifact
class SimpleModel {
  final String name;
  final int age;

  const SimpleModel({required this.name, required this.age});
}

@artifact
class ModelWithDefaults {
  final String name;
  final int count;
  final double ratio;
  final bool active;

  const ModelWithDefaults({
    this.name = 'default',
    this.count = 0,
    this.ratio = 1.0,
    this.active = true,
  });
}

@artifact
class ModelWithNullable {
  final String? optionalName;
  final int? optionalAge;
  final double? optionalRatio;

  const ModelWithNullable({
    this.optionalName,
    this.optionalAge,
    this.optionalRatio,
  });
}

@artifact
class ModelWithRename {
  @rename('n')
  final String name;
  @rename('a')
  final int age;
  @rename('desc')
  final String? description;

  const ModelWithRename({
    required this.name,
    required this.age,
    this.description,
  });
}

// ============================================================================
// Enum Models
// ============================================================================

enum Status { pending, active, completed, cancelled }

enum Priority { low, medium, high, urgent }

@artifact
class ModelWithEnum {
  final String name;
  final Status status;
  final Priority? priority;

  const ModelWithEnum({
    required this.name,
    required this.status,
    this.priority,
  });
}

// ============================================================================
// Collection Models
// ============================================================================

@artifact
class ModelWithList {
  final List<String> tags;
  final List<int> numbers;
  final List<double> values;

  const ModelWithList({
    this.tags = const [],
    this.numbers = const [],
    this.values = const [],
  });
}

@artifact
class ModelWithSet {
  final Set<String> uniqueTags;
  final Set<int> uniqueNumbers;

  const ModelWithSet({
    this.uniqueTags = const {},
    this.uniqueNumbers = const {},
  });
}

@artifact
class ModelWithMap {
  final Map<String, int> scores;
  final Map<String, String> metadata;

  const ModelWithMap({
    this.scores = const {},
    this.metadata = const {},
  });
}

// ============================================================================
// Inheritance Models
// ============================================================================

@artifact
class Animal {
  final String name;
  final int health;

  const Animal({required this.name, this.health = 100});
}

@artifact
class Dog extends Animal {
  final String breed;
  final bool goodBoy;

  const Dog({
    required super.name,
    super.health = 100,
    required this.breed,
    this.goodBoy = true,
  });
}

@artifact
class Cat extends Animal {
  final int lives;
  final bool indoor;

  const Cat({
    required super.name,
    super.health = 100,
    this.lives = 9,
    this.indoor = true,
  });
}

@artifact
class Bird extends Animal {
  final double wingspan;
  final bool canFly;

  const Bird({
    required super.name,
    super.health = 100,
    required this.wingspan,
    this.canFly = true,
  });
}

// ============================================================================
// Nested Models
// ============================================================================

@artifact
class Address {
  final String street;
  final String city;
  final String zipCode;
  final String? country;

  const Address({
    required this.street,
    required this.city,
    required this.zipCode,
    this.country,
  });
}

@artifact
class Person {
  final String firstName;
  final String lastName;
  final int age;
  final Address address;

  const Person({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.address,
  });
}

@artifact
class Company {
  final String name;
  final Address headquarters;
  final List<Person> employees;

  const Company({
    required this.name,
    required this.headquarters,
    this.employees = const [],
  });
}

// ============================================================================
// Complex Nested Collections
// ============================================================================

@artifact
class Zoo {
  final String name;
  final List<Animal> animals;
  final Map<String, List<String>> exhibits;

  const Zoo({
    required this.name,
    this.animals = const [],
    this.exhibits = const {},
  });
}

@artifact
class Inventory {
  final Map<String, int> stock;
  final Set<String> categories;
  final List<Map<String, dynamic>> transactions;

  const Inventory({
    this.stock = const {},
    this.categories = const {},
    this.transactions = const [],
  });
}

// ============================================================================
// DateTime and Duration Models
// ============================================================================

@artifact
class Event {
  final String title;
  final DateTime startTime;
  final DateTime? endTime;
  final Duration duration;

  Event({
    required this.title,
    DateTime? startTime,
    this.endTime,
    Duration? duration,
  }) : startTime = startTime ?? DateTime.now(),
       duration = duration ?? const Duration(hours: 1);
}

@artifact
class Schedule {
  final List<Event> events;
  final DateTime createdAt;

  Schedule({
    this.events = const [],
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();
}

// ============================================================================
// Attachment Models
// ============================================================================

enum UIType { title, subtitle, body, hidden }

class UIAttachment extends attach<UIType> {
  const UIAttachment([super.data = UIType.body]);
}

const uiTitle = UIAttachment(UIType.title);
const uiSubtitle = UIAttachment(UIType.subtitle);
const uiBody = UIAttachment(UIType.body);
const uiHidden = UIAttachment(UIType.hidden);

@artifact
@attach(UIType.title)
class AttachmentModel {
  @uiTitle
  final String name;

  @uiSubtitle
  final String description;

  @uiBody
  final String content;

  @uiHidden
  final String internalId;

  const AttachmentModel({
    required this.name,
    required this.description,
    required this.content,
    required this.internalId,
  });
}

// ============================================================================
// Reflection Models
// ============================================================================

class CustomAnnotation {
  final String value;
  const CustomAnnotation([this.value = 'default']);
}

const customAnnotation = CustomAnnotation('test');

@Artifact(reflection: true)
@customAnnotation
class ReflectionModel {
  @customAnnotation
  final String name;
  final int value;

  const ReflectionModel({required this.name, required this.value});

  @customAnnotation
  String greet(String greeting) => '$greeting, $name!';

  int multiply(int a, {int b = 1}) => a * b * value;
}

// ============================================================================
// Schema Generation Models (disabled - has issues with primitive types)
// ============================================================================

// Schema generation for models containing primitive types like String, int, Map
// has known issues. Skipping schema tests for now.

// ============================================================================
// Compression Test Models (with compression: false)
// ============================================================================

@Artifact(compression: false)
class UncompressedModel {
  final String name;
  final int value;
  final List<String> items;

  const UncompressedModel({
    required this.name,
    required this.value,
    this.items = const [],
  });
}

// ============================================================================
// Complex Polymorphic Models
// ============================================================================

@artifact
class Vehicle {
  final String brand;
  final int year;

  const Vehicle({required this.brand, required this.year});
}

@artifact
class Car extends Vehicle {
  final int doors;
  final String fuelType;

  const Car({
    required super.brand,
    required super.year,
    required this.doors,
    required this.fuelType,
  });
}

@artifact
class Motorcycle extends Vehicle {
  final String type;
  final int engineCC;

  const Motorcycle({
    required super.brand,
    required super.year,
    required this.type,
    required this.engineCC,
  });
}

@artifact
class Garage {
  final String name;
  final List<Vehicle> vehicles;
  final Vehicle? featuredVehicle;

  const Garage({
    required this.name,
    this.vehicles = const [],
    this.featuredVehicle,
  });
}

// ============================================================================
// Edge Case Models
// ============================================================================

@artifact
class EmptyModel {
  const EmptyModel();
}

@artifact
class SingleFieldModel {
  final String value;
  const SingleFieldModel({required this.value});
}

@artifact
class AllPrimitivesModel {
  final String stringVal;
  final int intVal;
  final double doubleVal;
  final bool boolVal;

  const AllPrimitivesModel({
    required this.stringVal,
    required this.intVal,
    required this.doubleVal,
    required this.boolVal,
  });
}

@artifact
class DeeplyNestedModel {
  final String name;
  final DeeplyNestedModel? child;

  const DeeplyNestedModel({required this.name, this.child});
}
