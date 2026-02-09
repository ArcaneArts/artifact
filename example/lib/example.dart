import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

const Artifact model = Artifact(compression: true, reflection: true);

class Property {
  const Property();
}

@Property()
@model
class Person {
  @Property()
  final String firstName;

  @Property()
  final String? lastName;

  @Property()
  final DateTime? dateOfBirth;

  Person({required this.firstName, this.lastName, this.dateOfBirth});
}

abstract class TypeBoundManagerBase {
  Type get t;
}

class ClassPropertyManager<T extends Object?> implements TypeBoundManagerBase {
  const ClassPropertyManager();

  @override
  Type get t => T;
}

class FieldPropertyManager<T extends Object?> implements TypeBoundManagerBase {
  final ArtifactFieldMirror mirror;

  const FieldPropertyManager(this.mirror);

  @override
  Type get t => T;
}

void main() {
  // Trigger generated registration.
  Person(firstName: "").to.json;

  ArtifactTypeMirror? personType;
  for (ArtifactTypeMirror typeMirror
      in ArtifactReflection.withAnnotation<Property>()) {
    personType = typeMirror;
    break;
  }

  if (personType == null) {
    print(
      'No reflected classes found. Ensure generated artifacts are imported before calling reflection.',
    );
    return;
  }

  Object person = personType.construct();
  ArtifactMirror mirror = personType.bind(person);
  TypeBoundManagerBase classManager = personType
      .mapClassType<TypeBoundManagerBase>(<T>() => ClassPropertyManager<T>());

  print('class -> ${classManager.t}');

  for (ArtifactFieldMirror field in mirror.fields) {
    if (!field.hasAnnotation<Property>()) {
      continue;
    }

    TypeBoundManagerBase manager = field.mapFieldType<TypeBoundManagerBase>(
      <T>() => FieldPropertyManager<T>(field),
    );
    print('${field.name} -> ${manager.t}');
  }
}
