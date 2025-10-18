// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=Test;typedef _7=Sub;typedef _8=MapEntry;typedef _9=MapEntry<int, String>;typedef _a=ArgumentError;typedef _b=List;typedef _c=Set;typedef _d=bool;typedef _e=AEnum;typedef _f=List<Sub>;typedef _g=Set<int>;typedef _h=Map<int, String>;typedef _i=List<dynamic>;
const _2 _S=['aString','aInt','anEnum','aSub','subList','aSet','aMap','Missing required Test."aInt" in map ','Missing required Test."anEnum" in map ','Missing required Test."aSub" in map ','Missing required Test."subList" in map ','Missing required Test."aSet" in map ','Missing required Test."aMap" in map ','value'];const _i _V=['default'];const _d _T=true;const _d _F=false;const _5 _ = 0;
extension $Test on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]:_0.ea(aString),_S[1]:_0.ea(aInt),_S[2]:anEnum.name,_S[3]:aSub.toMap(),_S[4]:subList?.$m((e)=> e.toMap()).$l,_S[5]:aSet.$m((e)=> _0.ea(e)).$l,_S[6]:aMap.$m((k,v)=>_8('$k', _0.ea(v))),}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromYaml(String j)=>fromMap(_0.v(j));
  static _6 fromToml(String j)=>fromMap(_0.t(j));
  static _6 fromProperties(String j)=>fromMap(_0.g(j));
  static _6 get newInstance=>_6(aInt: 0,anEnum: AEnum.values.first,aSub: $Sub.newInstance,subList: null,aSet: {},aMap: {},);
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(aString: m.$c(_S[0]) ?  _0.da(m[_S[0]], _3) as _3 : _V[0],aInt: m.$c(_S[1])? _0.da(m[_S[1]], _5) as _5:(throw _a('${_S[7]}$m.')),anEnum: m.$c(_S[2])?_0.e(AEnum.values, m[_S[2]]) as AEnum:(throw _a('${_S[8]}$m.')),aSub: m.$c(_S[3])?$Sub.fromMap((m[_S[3]]) as _1):(throw _a('${_S[9]}$m.')),subList: m.$c(_S[4])? (m[_S[4]] as _b).$m((e)=>$Sub.fromMap((e) as _1)).$l:(throw _a('${_S[10]}$m.')),aSet: m.$c(_S[5])? (m[_S[5]] as _b).$m((e)=> _0.da(e, _5) as _5).$s:(throw _a('${_S[11]}$m.')),aMap: m.$c(_S[6])? _0.fe((m[_S[6]] as Map).$e.$m((e)=>_9(_0.p<_5>(e.key), _0.da(e.value, _3) as _3))):(throw _a('${_S[12]}$m.')),);}
  _6 copyWith({_3? aString,_d resetAString=_F,_5? aInt,_5? deltaAInt,_e? anEnum,_7? aSub,_f? subList,_f? appendSubList,_f? removeSubList,_g? aSet,_g? appendASet,_g? removeASet,_h? aMap,})=>_6(aString: resetAString?_V[0]:(aString??_H.aString),aInt: deltaAInt!=null?(aInt??_H.aInt)+deltaAInt:aInt??_H.aInt,anEnum: anEnum??_H.anEnum,aSub: aSub??_H.aSub,subList: (subList??_H.subList)?.$u(appendSubList,removeSubList),aSet: (aSet??_H.aSet).$u(appendASet,removeASet),aMap: aMap??_H.aMap,);
}
extension $Sub on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{_S[13]:_0.ea(value),}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromYaml(String j)=>fromMap(_0.v(j));
  static _7 fromToml(String j)=>fromMap(_0.t(j));
  static _7 fromProperties(String j)=>fromMap(_0.g(j));
  static _7 get newInstance=>_7();
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(value: m.$c(_S[13]) ?  _0.da(m[_S[13]], _5) as _5 : 42,);}
  _7 copyWith({_5? value,_d resetValue=_F,_5? deltaValue,})=>_7(value: deltaValue!=null?(value??_H.value)+deltaValue:resetValue?42:(value??_H.value),);
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _6 ||v == _7 ;
T $constructArtifact<T>() => T == _6 ?$Test.newInstance as T :T == _7 ?$Sub.newInstance as T : throw Exception();
_1 $artifactToMap(Object o)=>o is _6 ?o.toMap():o is _7 ?o.toMap():throw Exception();
T $artifactFromMap<T>(_1 m)=>T==_6 ?$Test.fromMap(m) as T:T==_7 ?$Sub.fromMap(m) as T: throw Exception();
