import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

const Artifact model = Artifact(compression: true, reflection: true);

@model
class Holder {
  final Map<String, AMeta> aMetas;
  final Map<String, BMeta> bMetas;

  const Holder({this.aMetas = const {}, this.bMetas = const {}});
}

@model
class Meta {
  const Meta();
}

@model
class AMeta extends Meta {
  final int a;

  const AMeta({this.a = 4});
}

@model
class BMeta extends Meta {
  final String b;

  const BMeta({this.b = "hello"});
}

void main() {
  Holder h = Holder(
    aMetas: {"a1": AMeta(a: 5)},
    bMetas: {"b1": BMeta(b: "world")},
  );

  print(h.to.json);

  Holder h2 = $Holder.from.json(h.to.json);

  print(h2.to.json);
}

@artifact
class VectorValue {
  final String magic$type;
  final List<double> vector;

  const VectorValue({this.magic$type = "vector", this.vector = const []});
}
