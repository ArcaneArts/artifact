// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "dart:core";

import "package:artifact/artifact.dart";
import "package:example/example.dart";

typedef _0 = ArtifactCodecUtil;
typedef _1 = Map<String, dynamic>;
typedef _2 = List<String>;
typedef _3 = String;
typedef _4 = dynamic;
typedef _5 = int;
typedef _6 = Base;
typedef _7 = double;
typedef _8 = bool;
typedef _9 = List<dynamic>;
const _2 _S = ['baseValue'];
const _9 _V = [];
const _8 _T = true;
const _8 _F = false;
const _5 _ = 0;

extension $Base on _6 {
  _6 get _H => this;
  _3 toJson({bool pretty = _F}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{_S[0]: _0.ea(baseValue)}.$nn;
  }

  static _6 fromJson(String j) => fromMap(_0.o(j));
  static _6 fromMap(_1 r) {
    _;
    _1 m = r.$nn;
    return _6(baseValue: m.$c(_S[0]) ? _0.da(m[_S[0]], _7) as _7 : 0);
  }

  _6 copyWith({_7? baseValue, _8 resetBaseValue = _F, _7? deltaBaseValue}) =>
      _6(
        baseValue:
            deltaBaseValue != null
                ? (baseValue ?? _H.baseValue) + deltaBaseValue
                : resetBaseValue
                ? 0
                : (baseValue ?? _H.baseValue),
      );
}
