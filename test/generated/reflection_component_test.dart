import 'package:artifact/artifact.dart';
import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

Type typeOf<T>() => T;

void main() {
  setUp(() {
    Person(name: 'bootstrap').toMap();
  });

  tearDown(() {
    receivedPingEvents = 0;
  });

  test('reflector exposes class field and method metadata', () {
    ArtifactTypeMirror? personType = ArtifactReflection.typeOf(Person);
    ArtifactTypeMirror? listenerType = ArtifactReflection.typeOf(ListenerModel);

    expect(personType, isNotNull);
    expect(personType!.classType, Person);
    expect(personType.field('name')?.fieldType, String);
    expect(personType.field('subtitle')?.fieldType.toString(), 'String?');

    expect(listenerType, isNotNull);
    expect(listenerType!.method('onPing'), isNotNull);

    ArtifactMethodInfo method = listenerType.method('onPing')!;
    expect(method.returnType.toString(), 'void');
    expect(method.orderedParameterTypes, <Type>[PingEvent]);
    expect(method.getAnnotations<EventHandler>().length, 1);
  });

  test('reflector exposes annotation metadata on class and fields', () {
    ArtifactTypeMirror personType = ArtifactReflection.typeOf(Person)!;

    Iterable<attach> classAnnotations = personType.getAnnotations<attach>();
    Iterable<attach> nameAnnotations =
        personType.field('name')!.getAnnotations<attach>();
    Iterable<attach> subtitleAnnotations =
        personType.field('subtitle')!.getAnnotations<attach>();

    expect(personType.hasAnnotation<attach>(), isTrue);
    expect(
      classAnnotations.map((annotation) => annotation.data),
      contains(UiHint.classLevel),
    );
    expect(
      nameAnnotations.map((annotation) => annotation.data),
      contains(UiHint.title),
    );
    expect(
      subtitleAnnotations.map((annotation) => annotation.data),
      contains(UiHint.subtitle),
    );
  });

  test('reflector reads and writes immutable fields through copy setter', () {
    ReflectModel model = ReflectModel(value: 9);
    ArtifactMirror mirror = ArtifactReflection.instanceOf(model)!;

    Object? before = mirror.getFieldValue('value');
    ArtifactMirror updatedMirror = mirror.setFieldValue('value', 12);
    ReflectModel updatedModel = updatedMirror.instance as ReflectModel;

    expect(before, 9);
    expect(updatedModel.value, 12);
  });

  test('reflector invokes methods with ordered parameters', () {
    ListenerModel listener = ListenerModel();
    ArtifactMirror mirror = ArtifactReflection.instanceOf(listener)!;

    mirror.callMethod('onPing', orderedParameters: <dynamic>[PingEvent()]);
    mirror.callMethod('onPing', orderedParameters: <dynamic>[PingEvent()]);

    expect(receivedPingEvents, 2);
  });

  test('reflection query apis filter by annotation and hierarchy', () {
    Set<Type> classWithAttach =
        ArtifactReflection.withAnnotation<attach>()
            .map((t) => t.classType)
            .toSet();
    Set<Type> fieldsWithAttach =
        ArtifactReflection.withFieldAnnotation<attach>()
            .map((t) => t.classType)
            .toSet();
    Set<Type> methodsWithEventHandler =
        ArtifactReflection.withMethodAnnotation<EventHandler>()
            .map((t) => t.classType)
            .toSet();

    expect(classWithAttach.contains(Person), isTrue);
    expect(fieldsWithAttach.contains(Person), isTrue);
    expect(methodsWithEventHandler.contains(ListenerModel), isTrue);

    Set<Type> artifactClasses =
        ArtifactAccessor.withAnnotationType(Artifact).map((e) => e.key).toSet();

    expect(artifactClasses.contains(Person), isTrue);
    expect(artifactClasses.contains(ReflectModel), isTrue);
    expect(ArtifactAccessor.reflectType(Person), isNotNull);
    expect(ArtifactAccessor.reflectType(typeOf<Person?>()), isNotNull);
    expect(ArtifactAccessor.reflectObject(Person(name: 'a')), isNotNull);
  });
}
