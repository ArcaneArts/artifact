import 'package:example/example.dart';
import 'package:example/gen/artifacts.gen.dart';

void main() {
  Base v = Ext();
  v = v.copyWith(baseValue: 5);

  print(v.runtimeType);
}
