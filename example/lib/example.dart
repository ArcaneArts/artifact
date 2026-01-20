import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

const Artifact model = Artifact(compression: false, reflection: true);

class NoRelfect {
  const NoRelfect();
}

@model
class DoReflect {
  const DoReflect();
}

@model
class NoOp {}

@model
class Person {
  @deprecated
  final String firstName;

  @DoReflect()
  @NoRelfect()
  final String lastName;
  @DoReflect()
  final DateTime? dateOfBirth;

  Person({required this.firstName, required this.lastName, this.dateOfBirth});

  @override
  bool operator ==(Object other) {
    return super == other;
  }

  @NoRelfect()
  @override
  int get hashCode => super.hashCode;

  @DoReflect()
  @override
  String toString() {
    return "f";
  }
}

void main() {
  Person p = Person(firstName: "John", lastName: "Doe");

  for (ArtifactAnnotatedField<DoReflect> i
      in p.$mirror.getAnnotatedFields<DoReflect>()) {
    DoReflect a = i.annotation;
    ArtifactFieldMirror f = i.field;
    dynamic value = f.value;
    print("${f.name} = $value");
  }
}
