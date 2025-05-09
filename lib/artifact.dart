library artifact;

import 'package:artifact/codec.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/shrink.dart';

const Artifact artifact = Artifact();

class Artifact {
  final bool generateSchema;

  const Artifact({this.generateSchema = false});
}

class codec {
  final ArtifactCodec c;

  const codec(this.c);
}

class describe {
  final String description;

  const describe(this.description);
}

class rename {
  final String newName;

  const rename(this.newName);
}

class attach<T> {
  final T data;

  const attach(this.data);
}
