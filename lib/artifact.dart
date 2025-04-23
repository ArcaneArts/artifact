library artifact;

import 'package:artifact/builder.dart';
import 'package:artifact/codec.dart';
import 'package:build/build.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/shrink.dart';

Builder artifactBuilderBuildRunner(BuilderOptions _) => ArtifactBuilder();

const Artifact artifact = Artifact();

class Artifact {
  const Artifact();
}

class codec {
  final ArtifactCodec c;

  const codec(this.c);
}
