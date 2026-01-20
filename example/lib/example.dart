import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

const Artifact model = Artifact(compression: false, reflection: true);

@model
class Person {
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;

  Person({required this.firstName, required this.lastName, this.dateOfBirth});
}

void main() {
  Person p = Person(firstName: "John", lastName: "Doe");

  for (var f in $Person.$fields) {
    print("${f.name} ${f.fieldType}");
    print(f.getValue(p));
  }
}
