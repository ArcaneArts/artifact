import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@Artifact(compression: false, reflection: false, generateSchema: false)
class Test {
  String name;
  @rename("agex")
  int? age;

  Test({this.name = "John Doe"});
}

void main() {
  Test inst = Test();
  print(inst.toJson(pretty: true));
  inst.name = "NewName";
  inst.age = 3;
  print(inst.toJson(pretty: true));

  inst = $Test.fromJson(inst.toJson());
  print(inst.toJson(pretty: true));
}
