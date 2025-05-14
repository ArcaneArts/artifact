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
  Map<String, dynamic> toMap() {
    _;
    return <String, dynamic>{'roles': roles.$m((e) => e.name).$l}.$nn;
  }

  static Test fromJson(String j) => fromMap(ArtifactCodecUtil.o(j));
  static Test fromMap(Map<String, dynamic> r) {
    _;
    Map<String, dynamic> m = r.$nn;
    return Test(
      roles:
          m.$c('roles')
              ? (m['roles'] as List)
                  .$m(
                    (e) =>
                        ArtifactCodecUtil.e(MemberRole.values, e) as MemberRole,
                  )
                  .$s
              : const {},
    );
  }

  Test copyWith({
    Set<MemberRole>? roles,
    bool resetRoles = _F,
    Set<MemberRole>? appendRoles,
    Set<MemberRole>? removeRoles,
  }) => Test(
    roles: ((resetRoles ? const {} : (roles ?? _H.roles)) as Set<MemberRole>)
        .$u(appendRoles, removeRoles),
  );
}
