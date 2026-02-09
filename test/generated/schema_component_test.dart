import 'package:artifact/gen/artifacts.gen.dart';
import 'package:test/test.dart';

void main() {
  test('schema component emits expected root shape', () {
    Map<String, dynamic> schema = $SchemaModel.schema;

    expect(schema['type'], 'object');
    expect(schema['additionalProperties'], isFalse);
    expect(schema['required'], <dynamic>[]);
  });

  test('schema component emits renamed described and typed properties', () {
    Map<String, dynamic> schema = $SchemaModel.schema;
    Map<String, dynamic> properties =
        schema['properties'] as Map<String, dynamic>;

    Map<String, dynamic> identifier =
        properties['identifier'] as Map<String, dynamic>;
    Map<String, dynamic> enabled =
        properties['enabled'] as Map<String, dynamic>;
    Map<String, dynamic> samples =
        properties['samples'] as Map<String, dynamic>;
    Map<String, dynamic> sampleItems = samples['items'] as Map<String, dynamic>;

    expect(identifier['type'], 'integer');
    expect(enabled['type'], 'boolean');
    expect(enabled['description'], 'Enabled flag');
    expect(samples['type'], 'array');
    expect(sampleItems['type'], 'integer');
  });
}
