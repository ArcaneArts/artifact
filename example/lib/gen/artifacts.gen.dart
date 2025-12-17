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
typedef _6 = ArtifactModelExporter;
typedef _7 = ArgumentError;
typedef _8 = Exception;
typedef _9 = SomeModel;
typedef _a = ParentThing;
typedef _b = ArtifactModelImporter<SomeModel>;
typedef _c = bool;
typedef _d = ArtifactModelImporter<ParentThing>;
typedef _e = List;
typedef _f = List<SomeModel>;
typedef _g = ArtifactAccessor;
typedef _h = List<dynamic>;
_7 _1x(_3 c, _3 f) => _7('${_S[5]}$c.$f');
const _2 _S = [
  'name',
  'address',
  'SomeModel',
  'models',
  'example',
  'Missing required ',
];
const _h _V = [<_9>[]];
const _c _T = true;
const _c _F = false;
_5 _ =
    (() {
      if (!_g.$i(_S[4])) {
        _g.$r(
          _S[4],
          _g(
            isArtifact: $isArtifact,
            artifactMirror: {},
            constructArtifact: $constructArtifact,
            artifactToMap: $artifactToMap,
            artifactFromMap: $artifactFromMap,
          ),
        );
      }
      return 0;
    })();

extension $SomeModel on _9 {
  _9 get _H => this;
  _6 get to => _6(toMap);
  _1 toMap() {
    _;
    return <_3, _4>{
      'age': _0.ea(age),
      _S[0]: _0.ea(name),
      'ssn': _0.ea(ssn),
      _S[1]: _0.ea(address),
    }.$nn;
  }

  static _b get from => _b(fromMap);
  static _9 fromMap(_1 r) {
    _;
    _1 m = r.$nn;
    return _9(
      age: m.$c('age') ? _0.da(m['age'], _5) as _5 : throw _1x(_S[2], 'age'),
      name: m.$c(_S[0]) ? _0.da(m[_S[0]], _3) as _3 : throw _1x(_S[2], _S[0]),
      ssn: m.$c('ssn') ? _0.da(m['ssn'], _3) as _3 : throw _1x(_S[2], 'ssn'),
      address:
          m.$c(_S[1]) ? _0.da(m[_S[1]], _3) as _3 : throw _1x(_S[2], _S[1]),
    );
  }

  _9 copyWith({_5? age, _5? deltaAge, _3? name, _3? ssn, _3? address}) => _9(
    age: deltaAge != null ? (age ?? _H.age) + deltaAge : age ?? _H.age,
    name: name ?? _H.name,
    ssn: ssn ?? _H.ssn,
    address: address ?? _H.address,
  );
  static _9 get newInstance => _9(age: 0, name: '', ssn: '', address: '');
}

extension $ParentThing on _a {
  _a get _H => this;
  _6 get to => _6(toMap);
  _1 toMap() {
    _;
    return <_3, _4>{_S[3]: models.$m((e) => e.toMap()).$l}.$nn;
  }

  static _d get from => _d(fromMap);
  static _a fromMap(_1 r) {
    _;
    _1 m = r.$nn;
    return _a(
      models:
          m.$c(_S[3])
              ? (m[_S[3]] as _e)
                  .$m((e) => $SomeModel.fromMap((e) as Map<String, dynamic>))
                  .$l
              : _V[0],
    );
  }

  _a copyWith({
    _f? models,
    _c resetModels = _F,
    _f? appendModels,
    _f? removeModels,
  }) => _a(
    models: ((resetModels ? _V[0] : (models ?? _H.models)) as _f).$u(
      appendModels,
      removeModels,
    ),
  );
  static _a get newInstance => _a();
}

bool $isArtifact(dynamic v) =>
    v == null
        ? false
        : v is! Type
        ? $isArtifact(v.runtimeType)
        : v == _9 || v == _a;
T $constructArtifact<T>() =>
    T == _9
        ? $SomeModel.newInstance as T
        : T == _a
        ? $ParentThing.newInstance as T
        : throw _8();
_1 $artifactToMap(Object o) =>
    o is _9
        ? o.toMap()
        : o is _a
        ? o.toMap()
        : throw _8();
T $artifactFromMap<T>(_1 m) =>
    T == _9
        ? $SomeModel.fromMap(m) as T
        : T == _a
        ? $ParentThing.fromMap(m) as T
        : throw _8();
