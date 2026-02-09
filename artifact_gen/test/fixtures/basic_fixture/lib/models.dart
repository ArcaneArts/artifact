import 'package:artifact/artifact.dart';

const bool _compression = false;
const Artifact plainArtifact = Artifact(compression: _compression);
const Artifact reflectArtifact = Artifact(
  compression: _compression,
  reflection: true,
);
const Artifact schemaArtifact = Artifact(
  compression: _compression,
  generateSchema: true,
);

class Compact {
  final int raw;

  const Compact(this.raw);
}

class CompactCodec extends ArtifactCodec<int, Compact> {
  const CompactCodec();

  @override
  Compact? decode(int? value) => value == null ? null : Compact(value);

  @override
  int? encode(Compact? value) => value?.raw;
}

@plainArtifact
class FixtureBase {
  final int id;

  const FixtureBase({this.id = 1});
}

@plainArtifact
class FixtureChild extends FixtureBase {
  final String name;

  const FixtureChild({super.id = 2, this.name = 'child'});
}

@plainArtifact
class FixtureZoo {
  final List<FixtureBase> items;

  const FixtureZoo({this.items = const <FixtureBase>[]});
}

@plainArtifact
class FixtureModel {
  @rename('v')
  final int value;

  final String label;

  @codec(CompactCodec())
  final Compact compact;

  const FixtureModel({
    this.value = 4,
    this.label = 'label',
    this.compact = const Compact(9),
  });
}

@reflectArtifact
class ReflectFixture {
  final int count;

  const ReflectFixture({this.count = 1});
}

@schemaArtifact
class SchemaFixture {
  @rename('identifier')
  final int id;

  final bool active;

  const SchemaFixture({this.id = 1, this.active = true});
}

class EverythingAnnotation {
  final String aString;
  final int aInt;
  final double aDouble;
  final List<bool> aBools;
  final Map<String, dynamic> aRawMap;
  final Map<String, String>? aStringMapN;
  final List<String>? aStringListN;
  final Set<AConstThing> aConstThings;

  const EverythingAnnotation({
    this.aString = 'default',
    this.aInt = 42,
    this.aDouble = 3.14,
    this.aBools = const [true, false],
    this.aRawMap = const {'key': 'value'},
    this.aStringMapN,
    this.aStringListN,
    this.aConstThings = const {AConstThing()},
  });
}

class AConstThing {
  final List<String> aL;
  final int? x;

  const AConstThing({this.aL = const ['a', 'b', 'c'], this.x});
}

@EverythingAnnotation()
@reflectArtifact
class ReflectAnnotationVisibility {
  @EverythingAnnotation()
  final String someField;

  @EverythingAnnotation()
  final int? someInt;

  const ReflectAnnotationVisibility({this.someField = 'field', this.someInt});

  @EverythingAnnotation()
  int doSomething(int a, int b) => a + b;
}
