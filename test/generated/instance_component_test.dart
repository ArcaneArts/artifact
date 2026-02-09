import 'package:artifact/gen/artifacts.gen.dart';
import 'package:artifact/test_models/feature_models.dart';
import 'package:test/test.dart';

void main() {
  test('instance component exposes generated newInstance per model', () {
    Person person = $Person.newInstance;
    Animal animal = $Animal.newInstance;
    Dog dog = $Dog.newInstance;
    Zoo zoo = $Zoo.newInstance;
    ListenerModel listener = $ListenerModel.newInstance;
    FeatureModel feature = $FeatureModel.newInstance;
    ReflectModel reflect = $ReflectModel.newInstance;
    SchemaModel schema = $SchemaModel.newInstance;

    expect(person.name, '');
    expect(animal.hp, 10);
    expect(dog.hp, 20);
    expect(dog.goodBoy, isTrue);
    expect(zoo.animals, <Animal>[]);
    expect(listener.id, 0);
    expect(feature.ratio, 0);
    expect(reflect.value, 1);
    expect(schema.id, 1);
  });

  test('global construct helper returns generated instances', () {
    FeatureModel feature = $constructArtifact<FeatureModel>();
    Dog dog = $constructArtifact<Dog>();
    SchemaModel schema = $constructArtifact<SchemaModel>();

    expect(feature, isA<FeatureModel>());
    expect(feature.ratio, 0);
    expect(dog, isA<Dog>());
    expect(schema.enabled, isTrue);
  });

  test('global artifact registry helpers map values correctly', () {
    FeatureModel model = FeatureModel(ratio: 1.25, weird: const Weird(91));

    bool modelArtifact = $isArtifact(model);
    bool typeArtifact = $isArtifact(FeatureModel);
    bool randomArtifact = $isArtifact('nope');

    Map<String, dynamic> map = $artifactToMap(model);
    FeatureModel fromMap = $artifactFromMap<FeatureModel>(map);

    expect(modelArtifact, isTrue);
    expect(typeArtifact, isTrue);
    expect(randomArtifact, isFalse);
    expect(fromMap.ratio, 1.25);
    expect(fromMap.weird.value, 91);
  });
}
