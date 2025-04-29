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
typedef _6 = User;
typedef _7 = Test;
typedef _8 = ArgumentError;
typedef _9 = bool;
typedef _a = MapEntry;
typedef _b = MapEntry<String, User>;
typedef _c = List;
typedef _d = Set;
typedef _e = List<User>;
typedef _f = Set<User>;
typedef _g = Map<String, User>;
typedef _h = List<dynamic>;
const _2 _S = [
  'Missing required User."x" in map ',
  'usersNL',
  'usersL',
  'usersS',
  'usersNS',
  'usersM',
  'usersNM',
];
const _h _V = [<_6>[], <_6>{}, <_3, _6>{}];
const _9 _T = true;
const _9 _F = false;
const _5 _ = 0;

extension $User on _6 {
  _6 get _H => this;
  _3 toJson({bool pretty = _F}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{'x': _0.ea(x)}.$nn;
  }

  static _6 fromJson(String j) => fromMap(_0.o(j));
  static _6 fromMap(_1 r) {
    _;
    _1 m = r.$nn;
    return _6(
      x: m.$c('x') ? _0.da(m['x'], _5) as _5 : (throw _8('${_S[0]}$m.')),
    );
  }

  _6 copyWith({_5? x, _5? deltaX}) =>
      _6(x: deltaX != null ? (x ?? _H.x) + deltaX : x ?? _H.x);
}

extension $Test on _7 {
  _7 get _H => this;
  _3 toJson({bool pretty = _F}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{
      _S[1]: usersNL?.$m((e) => e.toMap()).$l,
      _S[2]: usersL.$m((e) => e.toMap()).$l,
      _S[3]: usersS.$m((e) => e.toMap()).$s,
      _S[4]: usersNS?.$m((e) => e.toMap()).$s,
      _S[5]: usersM.$m((k, v) => _a(k, v.toMap())),
      _S[6]: usersNM?.$m((k, v) => _a(k, v.toMap())),
    }.$nn;
  }

  static _7 fromJson(String j) => fromMap(_0.o(j));
  static _7 fromMap(_1 r) {
    _;
    _1 m = r.$nn;
    return _7(
      usersNL:
          m.$c(_S[1])
              ? (m[_S[1]] as _c).$m((e) => $User.fromMap((e) as _1)).$l
              : _V[0],
      usersL:
          m.$c(_S[2])
              ? (m[_S[2]] as _c).$m((e) => $User.fromMap((e) as _1)).$l
              : _V[0],
      usersS:
          m.$c(_S[3])
              ? (m[_S[3]] as _c).$m((e) => $User.fromMap((e) as _1)).$s
              : _V[1],
      usersNS:
          m.$c(_S[4])
              ? (m[_S[4]] as _c).$m((e) => $User.fromMap((e) as _1)).$s
              : _V[1],
      usersM:
          m.$c(_S[5])
              ? _0.fe(
                (m[_S[5]] as Map).$e.$m(
                  (e) => _b(e.key, $User.fromMap((e.value) as _1)),
                ),
              )
              : _V[2],
      usersNM:
          m.$c(_S[6])
              ? _0.fe(
                (m[_S[6]] as Map).$e.$m(
                  (e) => _b(e.key, $User.fromMap((e.value) as _1)),
                ),
              )
              : _V[2],
    );
  }

  _7 copyWith({
    _e? usersNL,
    _9 deleteUsersNL = _F,
    _9 resetUsersNL = _F,
    _e? appendUsersNL,
    _e? removeUsersNL,
    _e? usersL,
    _9 resetUsersL = _F,
    _e? appendUsersL,
    _e? removeUsersL,
    _f? usersS,
    _9 resetUsersS = _F,
    _f? appendUsersS,
    _f? removeUsersS,
    _f? usersNS,
    _9 deleteUsersNS = _F,
    _9 resetUsersNS = _F,
    _f? appendUsersNS,
    _f? removeUsersNS,
    _g? usersM,
    _9 resetUsersM = _F,
    _g? usersNM,
    _9 deleteUsersNM = _F,
    _9 resetUsersNM = _F,
  }) => _7(
    usersNL: ((deleteUsersNL
                ? null
                : resetUsersNL
                ? _V[0]
                : (usersNL ?? _H.usersNL))
            as _e?)
        ?.$u(appendUsersNL, removeUsersNL),
    usersL: ((resetUsersL ? _V[0] : (usersL ?? _H.usersL)) as _e).$u(
      appendUsersL,
      removeUsersL,
    ),
    usersS: ((resetUsersS ? _V[1] : (usersS ?? _H.usersS)) as _f).$u(
      appendUsersS,
      removeUsersS,
    ),
    usersNS: ((deleteUsersNS
                ? null
                : resetUsersNS
                ? _V[1]
                : (usersNS ?? _H.usersNS))
            as _f?)
        ?.$u(appendUsersNS, removeUsersNS),
    usersM: resetUsersM ? _V[2] : (usersM ?? _H.usersM),
    usersNM:
        deleteUsersNM
            ? null
            : resetUsersNM
            ? _V[2]
            : (usersNM ?? _H.usersNM),
  );
}
