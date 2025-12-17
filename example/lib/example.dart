import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@artifact
class SomeModel {
  final int age;
  final String name;
  final String ssn;
  final String address;

  const SomeModel({
    required this.age,
    required this.name,
    required this.ssn,
    required this.address,
  });
}

@artifact
class ParentThing {
  final List<SomeModel> models;

  const ParentThing({this.models = const []});
}

void main() {
  $artifactCipher = "derp";

  ParentThing m = ParentThing(
    models: [
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
      SomeModel(
        name: "Daniel",
        address: "115 Kanter Dr",
        age: 29,
        ssn: "123456789",
      ),
    ],
  );

  print(m.to.toon);
}
