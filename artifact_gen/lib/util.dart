import 'package:analyzer/dart/element/element.dart';
import 'package:toxic/extensions/iterable.dart';

extension XClassElement on ClassElement {
  ConstructorElement? get defaultConstructor =>
      constructors.select((i) => i.name == "new");
}

extension XConstructorElement on ConstructorElement {
  List<FormalParameterElement> get aParams {
    List<FormalParameterElement> params = <FormalParameterElement>[];
    for (FormalParameterElement p in formalParameters) {
      bool matchesField = enclosingElement.getField(p.name ?? "") != null;
      if (p.isInitializingFormal || p.isSuperFormal || matchesField) {
        params.add(p);
      }
    }

    return params;
  }
}
