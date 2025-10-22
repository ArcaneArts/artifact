import 'package:analyzer/dart/element/element.dart';
import 'package:toxic/extensions/iterable.dart';

extension XClassElement on ClassElement {
  ConstructorElement? get defaultConstructor =>
      constructors.select((i) => i.name == "new");
}
