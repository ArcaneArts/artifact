import 'package:artifact/artifact.dart';

const Artifact plainArtifact = Artifact(compression: false);
const Artifact reflectArtifact = Artifact(compression: false, reflection: true);
const Artifact schemaArtifact = Artifact(
  compression: false,
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
