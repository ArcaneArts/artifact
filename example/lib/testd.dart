import 'package:example/example.dart';
import 'package:example/gen/artifacts.gen.dart';

void main() {
  Test t = Test();

  print($Test.fromMap(t.toMap()));
}
