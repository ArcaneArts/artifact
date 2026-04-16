import 'dart:io';

import 'package:test/test.dart';

Future<void> _runChecked(String workingDirectory, List<String> args) async {
  String executable = Platform.resolvedExecutable;
  List<String> commandArgs = <String>['--suppress-analytics', ...args];
  ProcessResult result = await Process.run(
    executable,
    commandArgs,
    workingDirectory: workingDirectory,
  );

  if (result.exitCode != 0) {
    fail(
      'Command failed in $workingDirectory:\n'
      '$executable ${commandArgs.join(' ')}\n'
      'exit=${result.exitCode}\n'
      'stdout:\n${result.stdout}\n'
      'stderr:\n${result.stderr}',
    );
  }
}

void main() {
  String fixtureDir = Directory('test/fixtures/basic_fixture').absolute.path;
  String compressedFixtureDir =
      Directory('test/fixtures/compressed_fixture').absolute.path;

  String artifactsPath = '$fixtureDir/lib/gen/artifacts.gen.dart';
  String exportsPath = '$fixtureDir/lib/gen/exports.gen.dart';
  String compressedArtifactsPath =
      '$compressedFixtureDir/lib/gen/artifacts.gen.dart';
  String compressedExportsPath =
      '$compressedFixtureDir/lib/gen/exports.gen.dart';

  setUpAll(() async {
    await _runChecked(fixtureDir, <String>['pub', 'get']);
    await _runChecked(fixtureDir, <String>[
      'run',
      'build_runner',
      'build',
      '--delete-conflicting-outputs',
    ]);
    await _runChecked(compressedFixtureDir, <String>['pub', 'get']);
    await _runChecked(compressedFixtureDir, <String>[
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
    String generated = File(artifactsPath).readAsStringSync();

    expect(generated, contains('extension \$FixtureModel'));
    expect(generated, contains('Map<String,dynamic> toMap()'));
    expect(generated, contains('static FixtureModel fromMap'));
    expect(generated, contains("'v'"));
    expect(generated, contains('_subclass_FixtureBase'));
    expect(generated, contains('static Map<String,dynamic> get schema'));
    expect(generated, contains('static List<\$AFld> get \$fields'));
    expect(generated, contains('ArtifactCodecUtil.r(const [CompactCodec()]);'));
    expect(generated, contains('List<String?>'));
    expect(generated, contains('Set<ASubObject?>'));
    expect(generated, contains('Map<String, ASubObject?>'));
    expect(generated, contains('EmailValidator(message: "Bad Email2")'));
    expect(generated, contains('ArtifactDataUtil.a<ASubObject>('));
    expect(
      generated,
      contains('ArtifactDataUtil.a<NullableReflectSubObject>('),
    );
  });

  test('generated artifacts file includes recursive type descriptors', () {
    String generated = File(artifactsPath).readAsStringSync();

    expect(generated, contains(r'$AClass<RootObject>('));
    expect(generated, contains(r'$AT<RootObject>()'));
    expect(generated, contains(r'$AT<AnEnum>.e(()=>AnEnum.values)'));
    expect(generated, contains(r'$AT<AnEnum?>.e(()=>AnEnum.values)'));
    expect(generated, contains(r'$AT<List<String?>>([$AT<String?>()])'));
    expect(
      generated,
      contains(r'$AT<List<AnEnum>>([$AT<AnEnum>.e(()=>AnEnum.values)])'),
    );
    expect(
      generated,
      contains(
        r'$AT<Map<String, List<ASubObject>>>([$AT<String>(),$AT<List<ASubObject>>([$AT<ASubObject>()])])',
      ),
    );
    expect(generated, contains(r'$AMth<ReflectAnnotationVisibility, int>('));
    expect(generated, contains(r'$AT<int>(),[$AT<int>(),$AT<int>(),],{},),'));
  });

  test('generated exports file references generated artifact exports', () {
    String exports = File(exportsPath).readAsStringSync();
    expect(exports, contains("export 'artifacts.gen.dart';"));
  });

  test('compressed fixture generates artifacts and exports files', () {
    expect(File(compressedArtifactsPath).existsSync(), isTrue);
    expect(File(compressedExportsPath).existsSync(), isTrue);
  });

  test(
    'compressed fixture escapes dollar signs in compressed string tables',
    () {
      String generated = File(compressedArtifactsPath).readAsStringSync();

      expect(generated, contains(r"'magic\$type'"));
      expect(generated, isNot(contains(r"'magic$type'")));
      expect(generated, contains(r'(i)=>i.magic$type'));
      expect(generated, contains(r'schema=>{'));
    },
  );
}
