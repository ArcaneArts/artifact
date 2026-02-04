import 'package:artifact/artifact.dart';

const Artifact model = Artifact(compression: true, reflection: true);

class SomeAnnotation {
  final bool thing;

  const SomeAnnotation({this.thing = false});
}

//
@model
class Person {
  @SomeAnnotation()
  final String firstName;

  @SomeAnnotation()
  final String lastName;
  @SomeAnnotation()
  final DateTime? dateOfBirth;

  @SomeAnnotation()
  Person({required this.firstName, required this.lastName, this.dateOfBirth});

  @SomeAnnotation()
  @override
  bool operator ==(Object other) {
    return super == other;
  }

  @SomeAnnotation()
  @override
  int get hashCode => super.hashCode;

  @SomeAnnotation()
  @override
  String toString() {
    return "f";
  }
}

void main() {
  Person p = Person(firstName: "John", lastName: "Doe");
}
