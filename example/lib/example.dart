import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@Artifact(compression: false, reflection: true)
class HelloReflection {
  final String name;
  final int age;
  final List<SubObject> subs;

  const HelloReflection({
    this.name = "John Doe",
    this.age = 30,
    this.subs = const [SubObject()],
  });
}

@artifact
class SubObject {
  final String desc;
  final List<String> options;

  const SubObject({
    this.desc = "A sub object",
    this.options = const ["a", "b", "c"],
  });
}

void main() {
  HelloReflection inst = HelloReflection(age: 25);
  print("--- JSON ---");
  print(inst.toJson(pretty: true));
  print("--- TOML ---");
  print(inst.toToml());
  print("--- YAML ---");
  print(inst.toYaml());
  print("--- XML ---");
  print(inst.toXml(pretty: true));
  print("--- PROPERTIES ---");
  print(inst.toProperties());
  print("------------");
}
