// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
import "package:example/example.dart";
import "dart:core";
import "package:artifact/artifact.dart";
typedef _0 = ArtifactCodecUtil;
typedef _1 = Map<String, dynamic>;
typedef _2 = List<String>;
typedef _3 = String;
typedef _4 = dynamic;
typedef _5 = int;
typedef _6 = AllFields;
typedef _7 = MapEntry<String, int>;
typedef _8 = MapEntry<String, dynamic>;
typedef _9 = ArgumentError;
typedef _a = List;
typedef _b = MapEntry;
typedef _c = Remote;
typedef _d = double;
typedef _e = RemoteCodec;
_2 _S = ['something','somethings','test','mappedSomethings','remoteClass','doub','Missing required AllFields."something" in map ','Missing required AllFields."remoteClass" in map ','Missing required AllFields."x" in map '];
const bool _T = true;
const bool _F = false;
_5 _ = ((){
  _0.r(const [_e()]);
  return 0;
})();

extension $AllFields on _6 {
  _6 get _t => this;
  _3 toJson({bool pretty = false}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{
      _S[0]: something,
      _S[1]:  somethings.map((e) => e).toList(),
      _S[2]:  test.map((k, v) => MapEntry(k,  _0.ea(v))),
      _S[3]:  mappedSomethings.map((k, v) => MapEntry(k, v)),
      _S[4]:  _0.ea(remoteClass),
      'e':  e?.name,
      'x':  _0.ea(x),
      'str':  _0.ea(str),
      _S[5]:  _0.ea(doub),
    };
  }
  static _6 fromJson(String j) => fromMap(_0.o(j));
  static _6 fromMap(_1 map) {
    _;
    return AllFields(
      something: map.$c(_S[0]) ? map[_S[0]] : (throw _9('${_S[6]}$map.')),
      somethings: map.$c(_S[1]) ?  (map[_S[1]] as _a).map((e) => e).toList() : const [],
      test: map.$c(_S[2]) ?  Map.fromEntries((map[_S[2]] as Map).$e.$m((e) => _7(e.key,  _0.da(e.value, _5) as _5))) : const {},
      mappedSomethings: map.$c(_S[3]) ?  Map.fromEntries((map[_S[3]] as Map).$e.$m((e) => _8(e.key, e.value))) : const {},
      remoteClass: map.$c(_S[4]) ?  _0.da(map[_S[4]], _c) as _c : (throw _9('${_S[7]}$map.')),
      e: map.$c('e') ? _0.e(AnyEnum.values, map['e']) as AnyEnum? : AnyEnum.a,
      x: map.$c('x') ?  _0.da(map['x'], _5) as _5 : (throw _9('${_S[8]}$map.')),
      str: map.$c('str') ?  _0.da(map['str'], _3) as _3? : null,
      doub: map.$c(_S[5]) ?  _0.da(map[_S[5]], _d) as _d : 3,
    );
  }
  _6 copyWith({
    _4? something,
    List<dynamic>? somethings,
    bool resetSomethings = _F,
    Map<String, int>? test,
    bool resetTest = _F,
    _1? mappedSomethings,
    bool resetMappedSomethings = _F,
    _c? remoteClass,
    AnyEnum? e,
    bool deleteE = _F,
    bool resetE = _F,
    _5? x,
    String? str,
    bool deleteStr = _F,
    _d? doub,
    bool resetDoub = _F,
  }) 
    => AllFields(
      something: something ?? _t.something,
      somethings: resetSomethings ? const [] : (somethings ?? _t.somethings),
      test: resetTest ? const {} : (test ?? _t.test),
      mappedSomethings: resetMappedSomethings ? const {} : (mappedSomethings ?? _t.mappedSomethings),
      remoteClass: remoteClass ?? _t.remoteClass,
      e: deleteE ? null : resetE ? AnyEnum.a : (e ?? _t.e),
      x: x ?? _t.x,
      str: deleteStr ? null : (str ?? _t.str),
      doub: resetDoub ? 3 : (doub ?? _t.doub),
    );
  AllFields withSomething(_4 v) => copyWith(something:v);
  AllFields withSomethings(List<dynamic> v) => copyWith(somethings:v);
  AllFields resetSomethings() => copyWith(resetSomethings: _T);
  AllFields withTest(Map<String, int> v) => copyWith(test:v);
  AllFields resetTest() => copyWith(resetTest: _T);
  AllFields withMappedSomethings(_1 v) => copyWith(mappedSomethings:v);
  AllFields resetMappedSomethings() => copyWith(resetMappedSomethings: _T);
  AllFields withRemoteClass(_c v) => copyWith(remoteClass:v);
  AllFields withE(AnyEnum v) => copyWith(e:v);
  AllFields deleteE() => copyWith(deleteE: _T);
  AllFields resetE() => copyWith(resetE: _T);
  AllFields withX(_5 v) => copyWith(x:v);
  AllFields incrementX(_5 v) => copyWith(x:x+v);
  AllFields decrementX(_5 v) => copyWith(x:x-v);
  AllFields withStr(_3 v) => copyWith(str:v);
  AllFields deleteStr() => copyWith(deleteStr: _T);
  AllFields withDoub(_d v) => copyWith(doub:v);
  AllFields resetDoub() => copyWith(resetDoub: _T);
  AllFields incrementDoub(_d v) => copyWith(doub:doub+v);
  AllFields decrementDoub(_d v) => copyWith(doub:doub-v);

}

