library artifact;

import 'package:artifact/builder.dart';
import 'package:build/build.dart';

Builder artifactBuilderBuildRunner(BuilderOptions _) => ArtifactBuilder();

const Artifact artifact = Artifact();

class Artifact {
  const Artifact();
}
