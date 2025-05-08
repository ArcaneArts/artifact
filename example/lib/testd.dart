import 'package:example/example.dart';
import 'package:example/gen/artifacts.gen.dart';

void main() {
  Base v = Base(baseValue: 3);

  print($Base.fromMap({"baseValue": 0}));
}
