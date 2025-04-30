import 'package:artifact/artifact.dart';

@artifact
class Base {
  final int baseValue;

  const Base({this.baseValue = 0});
}

@artifact
class Ext extends Base {
  final int otherValue;

  const Ext({super.baseValue = 0, this.otherValue = 1});
}
