// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
import "package:example/example.dart";
import "package:artifact/artifact.dart";
import "dart:core";
typedef _0 = ArtifactCodecUtil;
typedef _1 = Map<String, dynamic>;
typedef _2 = List<String>;
typedef _3 = String;
typedef _4 = dynamic;
typedef _5 = int;
typedef _6 = AllFields;
typedef _7 = ArgumentError;
typedef _8 = bool;
_2 _S = ['finalX','nullX','defX','finalDefX','Missing required AllFields."finalX" in map '];
const bool _T = true;
const bool _F = false;
const _5 _ = 0;
extension $AllFields on _6 {
  _6 get _t => this;
  _3 toJson({bool pretty = false}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{
      _S[0]:  _0.ea(finalX),
      _S[1]:  _0.ea(nullX),
      _S[2]:  _0.ea(defX),
      _S[3]:  _0.ea(finalDefX),
    };
  }
  static _6 fromJson(String j) => fromMap(_0.o(j));
  static _6 fromMap(_1 map) {
    _;
    return AllFields(
      finalX: map.$c(_S[0]) ?  _0.da(map[_S[0]], _5) as _5 : (throw _7('${_S[4]}$map.')),
      nullX: map.$c(_S[1]) ?  _0.da(map[_S[1]], _5) as _5? : null,
      defX: map.$c(_S[2]) ?  _0.da(map[_S[2]], _5) as _5? : 4,
      finalDefX: map.$c(_S[3]) ?  _0.da(map[_S[3]], _5) as _5 : 99,
    );
  }
  _6 copyWith({
    _5? finalX,
    _5? deltaFinalX,
    _5? nullX,
    _8 deleteNullX = _F,
    _5? deltaNullX,
    _5? defX,
    _8 deleteDefX = _F,
    _8 resetDefX = _F,
    _5? deltaDefX,
    _5? finalDefX,
    _8 resetFinalDefX = _F,
    _5? deltaFinalDefX,
  }) 
    => AllFields(
      finalX: deltaFinalX != null ? (finalX ?? _t.finalX) + deltaFinalX : finalX ?? _t.finalX,
      nullX: deltaNullX != null ? (nullX ?? _t.nullX ?? 0) + deltaNullX :  deleteNullX ? null : (nullX ?? _t.nullX),
      defX: deltaDefX != null ? (defX ?? _t.defX ?? 0) + deltaDefX :  deleteDefX ? null : resetDefX ? 4 : (defX ?? _t.defX),
      finalDefX: deltaFinalDefX != null ? (finalDefX ?? _t.finalDefX) + deltaFinalDefX :  resetFinalDefX ? 99 : (finalDefX ?? _t.finalDefX),
    );
}

