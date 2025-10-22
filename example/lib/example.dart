import 'package:artifact/artifact.dart';

// default is just `@artifact`
@Artifact(compression: false, reflection: true)
class Test {
  final String aString;
  final int aInt;
  final AEnum anEnum;
  final Sub aSub;
  final List<Sub>? subList;
  final Set<int> aSet;

  @rename("m")
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

@Artifact(compression: false, reflection: true)
class Sub {
  final int value;

  Sub({this.value = 42});
}

enum AEnum { first, second, third }

void main() {}
