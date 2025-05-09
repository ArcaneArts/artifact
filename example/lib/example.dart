import 'package:artifact/artifact.dart';

@Artifact(generateSchema: true)
class Base {
  @describe("This is the base value")
  final double baseValue;

  @describe("This is the other value")
  final Other other;

  @describe("This is the list value")
  final List<String> aStringList;

  @describe("This is the list other value")
  final List<Other> aOtherList;

  const Base({
    this.baseValue = 0,
    this.other = const Other(),
    this.aStringList = const [],
    this.aOtherList = const [],
  });
}

@Artifact(generateSchema: true)
class Other {
  @describe("This is the name value")
  final String name;

  @describe("This is the age value")
  final int age;

  const Other({this.name = "", this.age = 0});
}
