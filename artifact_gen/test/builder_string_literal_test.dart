import 'package:artifact_gen/builder.dart';
import 'package:test/test.dart';

void main() {
  test('stringD escapes dollar signs when compression is off', () {
    ArtifactBuilder builder = ArtifactBuilder()..compression = false;

    expect(builder.stringD('magic\$type'), r"'magic\$type'");
  });

  test('dartStringLiteral escapes quotes backslashes and dollars', () {
    ArtifactBuilder builder = ArtifactBuilder();

    expect(builder.dartStringLiteral(r"don't \$break"), r"'don\'t \\\$break'");
  });
}
