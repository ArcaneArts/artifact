import 'package:artifact/artifact.dart';
import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    $events.unregisterAll();
    receivedPingEvents = 0;
  });

  test('serializes and deserializes with rename and codec', () {
    final FeatureModel model = FeatureModel(
      value: 8,
      ratio: 1.5,
      note: 'hello',
      numbers: const <int>[1, 2],
      tags: const <String>{'a'},
      mood: Mood.sad,
      weird: const Weird(42),
    );

    final Map<String, dynamic> map = model.toMap();
    expect(map['v'], 8);
    expect(map['ratio'], 1.5);
    expect(map['weird'], 42);

    final FeatureModel roundtrip = $FeatureModel.fromMap(map);
    expect(roundtrip.value, 8);
    expect(roundtrip.note, 'hello');
    expect(roundtrip.weird.value, 42);
    expect(roundtrip.mood, Mood.sad);

    final String json = model.to.json;
    final FeatureModel fromJson = $FeatureModel.from.json(json);
    expect(fromJson.value, 8);
  });

  test('copyWith supports delta reset delete append remove', () {
    final FeatureModel model = FeatureModel(
      ratio: 2.0,
      note: 'x',
      numbers: const <int>[1, 2],
      tags: const <String>{'a', 'b'},
    );

    final FeatureModel updated = model.copyWith(
      deltaValue: 3,
      deleteNote: true,
      appendNumbers: const <int>[3],
      removeTags: const <String>{'a'},
    );

    expect(updated.value, model.value + 3);
    expect(updated.note, isNull);
    expect(updated.numbers, const <int>[1, 2, 3]);
    expect(updated.tags.contains('a'), isFalse);

    final FeatureModel reset = updated.copyWith(resetValue: true);
    expect(reset.value, 4);
  });

  test('inheritance markers roundtrip subclasses', () {
    final Zoo zoo = Zoo(animals: const <Animal>[Dog(hp: 99, goodBoy: false)]);

    final Map<String, dynamic> map = zoo.toMap();
    final dynamic first = (map['animals'] as List<dynamic>).first;
    expect(first['_subclass_Animal'], 'Dog');

    final Zoo decoded = $Zoo.fromMap(map);
    expect(decoded.animals.first, isA<Dog>());
    expect((decoded.animals.first as Dog).goodBoy, isFalse);
  });

  test('attachments, reflection, schema, and global helpers work', () {
    final Person person = Person(name: 'Alice', subtitle: 'Engineer');

    expect(person.getAttachment<UiHint, String>(UiHint.title), 'Alice');
    expect(person.getAttachment<UiHint, String>(UiHint.subtitle), 'Engineer');
    expect($Person.rootAttachments.contains(UiHint.classLevel), isTrue);

    final ReflectModel reflected = ReflectModel(value: 9);
    expect(reflected.$mirror.hasAnnotation<Artifact>(), isTrue);
    expect($ReflectModel.$fields.any((dynamic f) => f.name == 'value'), isTrue);

    final Map<String, dynamic> schema = $SchemaModel.schema;
    expect(schema['properties']['identifier']['type'], 'integer');
    expect(schema['properties']['enabled']['description'], 'Enabled flag');

    final FeatureModel model = FeatureModel(ratio: 1.0);
    expect($isArtifact(model), isTrue);
    final Map<String, dynamic> converted = $artifactToMap(model);
    final FeatureModel fromMap = $artifactFromMap<FeatureModel>(converted);
    expect(fromMap.ratio, model.ratio);

    final FeatureModel constructed = $constructArtifact<FeatureModel>();
    expect(constructed, isA<FeatureModel>());
  });

  test('event handlers can be registered from reflected methods', () {
    final ListenerModel listener = ListenerModel();
    $events.registerListeners(listener);
    $events.callEvent(PingEvent());

    expect(receivedPingEvents, 1);
  });

  test('unified reflection api supports querying and invocation', () {
    final ArtifactTypeMirror? reflectedType = ArtifactReflection.typeOf(
      ReflectModel,
    );
    expect(reflectedType, isNotNull);
    expect(reflectedType!.classType, ReflectModel);
    expect(reflectedType.field('value')?.fieldType, int);

    final ReflectModel value = ReflectModel(value: 9);
    final ArtifactMirror? mirror = ArtifactReflection.instanceOf(value);
    expect(mirror, isNotNull);
    expect(mirror!.getFieldValue('value'), 9);
    expect(
      (mirror.setFieldValue('value', 12).instance as ReflectModel).value,
      12,
    );

    final ArtifactMethodInfo? onPing = ArtifactReflection.typeOf(
      ListenerModel,
    )?.method('onPing');
    expect(onPing, isNotNull);
    expect(onPing!.orderedParameterTypes, isNotEmpty);
    expect(onPing.orderedParameterTypes.first, PingEvent);
    expect(onPing.getAnnotations<EventHandler>().length, 1);

    final ListenerModel listener = ListenerModel();
    final ArtifactMirror listenerMirror =
        ArtifactReflection.instanceOf(listener)!;
    listenerMirror.callMethod('onPing', orderedParameters: [PingEvent()]);
    expect(receivedPingEvents, 1);

    final Set<Type> methodAnnotatedTypes =
        ArtifactReflection.withMethodAnnotation<EventHandler>()
            .map((t) => t.classType)
            .toSet();
    expect(methodAnnotatedTypes.contains(ListenerModel), isTrue);

    final Set<Type> annotationTypes =
        ArtifactAccessor.withAnnotationType(Artifact).map((e) => e.key).toSet();
    expect(annotationTypes.contains(ReflectModel), isTrue);
    expect(ArtifactAccessor.reflectObject(listener), isNotNull);
  });
}
