library artifact;

import 'package:artifact/codec.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/shrink.dart';

const Artifact artifact = Artifact();

class Artifact {
  const Artifact();
}

class codec {
  final ArtifactCodec c;

  const codec(this.c);
}
