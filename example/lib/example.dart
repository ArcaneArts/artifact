import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@artifact
class Test {
  final String aString;
  final int aInt;
  final AEnum anEnum;
  final Sub aSub;
  final List<Sub>? subList;
  final Set<int> aSet;
  final Map<int, String> aMap;

  const Test({
    this.aString = 'default',
    required this.aInt,
    required this.anEnum,
    required this.aSub,
    required this.subList,
    required this.aSet,
    required this.aMap,
  });
}

@artifact
class Sub {
  final int value;

  Sub({this.value = 42});
}

enum AEnum { first, second, third }

void main() {
  Map<String, dynamic> data = {"value": 41};

  Object object = $constructArtifact<Sub>();

  print(object.runtimeType);
  print($isArtifact(object));
  print((object as Sub).toYaml());
}
