// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "dart:core";

import "package:artifact/artifact.dart";
import "package:example/example.dart";

const bool _T = true;
const bool _F = false;
const int _ = 0;

extension $Test on Test {
  Test get _H => this;
  String toJson({bool pretty = _F}) => ArtifactCodecUtil.j(pretty, toMap);
  String toYaml() => ArtifactCodecUtil.y(toMap);
  String toToml() => ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty = _F}) => ArtifactCodecUtil.z(pretty, toMap);
  String toProperties() => ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap() {
    _;
    return <String, dynamic>{'name': ArtifactCodecUtil.ea(name)}.$nn;
  }

  static Test fromJson(String j) => fromMap(ArtifactCodecUtil.o(j));
  static Test fromYaml(String j) => fromMap(ArtifactCodecUtil.v(j));
  static Test fromToml(String j) => fromMap(ArtifactCodecUtil.t(j));
  static Test fromProperties(String j) => fromMap(ArtifactCodecUtil.g(j));
  static Test fromMap(Map<String, dynamic> r) {
    _;
    Map<String, dynamic> m = r.$nn;
    return Test(
      name:
          m.$c('name')
              ? ArtifactCodecUtil.da(m['name'], String) as String
              : "John Doe",
    );
  }

  Test copyWith({String? name, bool resetName = _F}) =>
      Test(name: resetName ? "John Doe" : (name ?? _H.name));
}
