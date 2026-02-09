import 'dart:io';

import 'package:test/test.dart';

Future<void> _runChecked(String workingDirectory, List<String> args) async {
  final ProcessResult result = await Process.run(
    'dart',
    args,
    workingDirectory: workingDirectory,
  );

  if (result.exitCode != 0) {
    fail(
      'Command failed in $workingDirectory:\n'
      'dart ${args.join(' ')}\n'
      'exit=${result.exitCode}\n'
      'stdout:\n${result.stdout}\n'
      'stderr:\n${result.stderr}',
    );
  }
}

void main() {
  final String fixtureDir =
      Directory('test/fixtures/basic_fixture').absolute.path;

  final String artifactsPath = '$fixtureDir/lib/gen/artifacts.gen.dart';
  final String exportsPath = '$fixtureDir/lib/gen/exports.gen.dart';

  setUpAll(() async {
    await _runChecked(fixtureDir, <String>['pub', 'get']);
    await _runChecked(fixtureDir, <String>[
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
  });

  test('generates artifacts and exports files', () {
    expect(File(artifactsPath).existsSync(), isTrue);
    expect(File(exportsPath).existsSync(), isTrue);
  });

  test('generated artifacts file contains core model APIs', () {
    final String generated = File(artifactsPath).readAsStringSync();

    expect(generated, contains('extension \$FixtureModel'));
    expect(generated, contains('Map<String,dynamic> toMap()'));
    expect(generated, contains('static FixtureModel fromMap'));
    expect(generated, contains("'v'"));
    expect(generated, contains('_subclass_FixtureBase'));
    expect(generated, contains('static Map<String,dynamic> get schema'));
    expect(generated, contains('static List<\$AFld> get \$fields'));
    expect(generated, contains('ArtifactCodecUtil.r(const [CompactCodec()]);'));
  });

  test('generated exports file references generated artifact exports', () {
    final String exports = File(exportsPath).readAsStringSync();
    expect(exports, contains("export 'artifacts.gen.dart';"));
  });
}
