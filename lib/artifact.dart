library artifact;

import 'package:artifact/codec.dart';

export 'package:artifact/codec.dart';
export 'package:artifact/shrink.dart';

const Artifact artifact = Artifact();

class Artifact {
  final bool generateSchema;
  final bool compression;
  final bool reflection;

  const Artifact({
    this.generateSchema = false,
    this.compression = true,
    this.reflection = false,
  });
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

class $AFld<I, T> {
  final String name;
  final T Function(I) getter;
  final I Function(I, T) setter;
  Type get iType => I;
  Type get fieldType => T;

  const $AFld(this.name, this.getter, this.setter);
}
