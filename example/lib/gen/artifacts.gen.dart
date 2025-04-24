// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=Animal;typedef _7=Dog;typedef _8=ArgumentError;typedef _9=bool;typedef _a=List<dynamic>;
const _2 _S=['_subclass_Animal','health','Missing required Animal."health" in map ','goodBoy','Missing required Dog."goodBoy" in map ','Missing required Dog."health" in map '];const _a _V=[];const _9 _T=true;const _9 _F=false;const _5 _ = 0;
extension $Animal on _6{
  _6 get _t=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;if (_t is _7){return (_t as _7).toMap();}return <_3, _4>{'hp':_0.ea(health),};}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromMap(_1 m){_;if(m.$c(_S[0])){String sub=m[_S[0]] as _3;switch(sub){case 'Dog':return $Dog.fromMap(m);}}return _6(health: m.$c(_S[1])? _0.da(m['hp'], _5) as _5:(throw _8('${_S[2]}$m.')),);}
  _6 copyWith({    _5? health,_5? deltaHealth,})=>_6(health: deltaHealth!=null?(health??_t.health)+deltaHealth:health??_t.health,);
}
extension $Dog on _7{
  _7 get _t=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]: 'Dog',_S[3]:_0.ea(goodBoy),_S[1]:_0.ea(health),};}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromMap(_1 m){_;return _7(goodBoy: m.$c(_S[3])? _0.da(m[_S[3]], _9) as _9:(throw _8('${_S[4]}$m.')),health: m.$c(_S[1])? _0.da(m[_S[1]], _5) as _5:(throw _8('${_S[5]}$m.')),);}
  _7 copyWith({    _9? goodBoy,    _5? health,_5? deltaHealth,})=>_7(goodBoy: goodBoy??_t.goodBoy,health: deltaHealth!=null?(health??_t.health)+deltaHealth:health??_t.health,);
}

