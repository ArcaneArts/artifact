// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
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
typedef _6 = double;
typedef _7 = bool;
typedef _8 = Duration;
typedef _9 = DateTime;
typedef _a = AllFields;
typedef _b = ArgumentError;
_2 _S = ['aString','anString','anrString','aInt','aDouble','aBool','aDateTime','aDuration','Missing required AllFields."aDateTime" in map '];
_5 _ = 0;
extension $AllFields on _a {
  _a get _t => this;
  _3 toJson({bool pretty = false}) => _0.j(pretty, toMap);
  _1 toMap() {
    _;
    return <_3, _4>{
      _S[0]:  _0.ea(aString),
      _S[1]:  _0.ea(anString),
      _S[2]:  _0.ea(anrString),
      _S[3]:  _0.ea(aInt),
      _S[4]:  _0.ea(aDouble),
      _S[5]:  _0.ea(aBool),
      _S[6]:  _0.ea(aDateTime),
      _S[7]:  _0.ea(aDuration),
    };
  }
  static _a fromJson(String j) => fromMap(_0.o(j));
  static _a fromMap(_1 map) {
    _;
    return AllFields(
      aString: map.$c(_S[0]) ?  _0.da(map[_S[0]], _3) as _3 : "",
      anString: map.$c(_S[1]) ?  _0.da(map[_S[1]], _3) as _3? : null,
      anrString: map.$c(_S[2]) ?  _0.da(map[_S[2]], _3) as _3? : "",
      aInt: map.$c(_S[3]) ?  _0.da(map[_S[3]], _5) as _5 : 0,
      aDouble: map.$c(_S[4]) ?  _0.da(map[_S[4]], _6) as _6 : 0.0,
      aBool: map.$c(_S[5]) ?  _0.da(map[_S[5]], _7) as _7 : false,
      aDateTime: map.$c(_S[6]) ?  _0.da(map[_S[6]], _9) as _9 : (throw _b('${_S[8]}$map.')),
      aDuration: map.$c(_S[7]) ?  _0.da(map[_S[7]], _8) as _8 : const Duration(),
    );
  }
  AllFields copyWith({
    _3? aString,
    bool resetAString = false,
    String? anString,
    bool deleteAnString = false,
    String? anrString,
    bool deleteAnrString = false,
    bool resetAnrString = false,
    _5? aInt,
    bool resetAInt = false,
    _6? aDouble,
    bool resetADouble = false,
    _7? aBool,
    bool resetABool = false,
    _9? aDateTime,
    _8? aDuration,
    bool resetADuration = false,
  }) 
    => AllFields(
      aString: resetAString ? "" : (aString ?? _t.aString),
      anString: deleteAnString ? null : (anString ?? _t.anString),
      anrString: deleteAnrString ? null : resetAnrString ? "" : (anrString ?? _t.anrString),
      aInt: resetAInt ? 0 : (aInt ?? _t.aInt),
      aDouble: resetADouble ? 0.0 : (aDouble ?? _t.aDouble),
      aBool: resetABool ? false : (aBool ?? _t.aBool),
      aDateTime: aDateTime ?? _t.aDateTime,
      aDuration: resetADuration ? const Duration() : (aDuration ?? _t.aDuration),
    );
  AllFields withAString(_3 v) => copyWith(aString:v);
  AllFields resetAString() => copyWith(resetAString: true);
  AllFields withAnString(_3 v) => copyWith(anString:v);
  AllFields deleteAnString() => copyWith(deleteAnString: true);
  AllFields withAnrString(_3 v) => copyWith(anrString:v);
  AllFields deleteAnrString() => copyWith(deleteAnrString: true);
  AllFields resetAnrString() => copyWith(resetAnrString: true);
  AllFields withAInt(_5 v) => copyWith(aInt:v);
  AllFields resetAInt() => copyWith(resetAInt: true);
  AllFields incrementAInt(_5 v) => copyWith(aInt:aInt+v);
  AllFields decrementAInt(_5 v) => copyWith(aInt:aInt-v);
  AllFields withADouble(_6 v) => copyWith(aDouble:v);
  AllFields resetADouble() => copyWith(resetADouble: true);
  AllFields incrementADouble(_6 v) => copyWith(aDouble:aDouble+v);
  AllFields decrementADouble(_6 v) => copyWith(aDouble:aDouble-v);
  AllFields withABool(_7 v) => copyWith(aBool:v);
  AllFields resetABool() => copyWith(resetABool: true);
  AllFields withADateTime(_9 v) => copyWith(aDateTime:v);
  AllFields withADuration(_8 v) => copyWith(aDuration:v);
  AllFields resetADuration() => copyWith(resetADuration: true);

}

