// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=Base;typedef _7=Other;typedef _8=double;typedef _9=List;typedef _a=bool;typedef _b=List<Other>;typedef _c=List<dynamic>;
const _2 _S=['baseValue','other','aStringList','aOtherList','type','object','properties','number','description','This is the base value','This is the other value','array','items','string','This is the list value','This is the list other value','required','additionalProperties','name','This is the name value','integer','This is the age value'];const _c _V=[Other(),<_3>[],<_7>[]];const _a _T=true;const _a _F=false;const _5 _ = 0;
extension $Base on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]:_0.ea(baseValue),_S[1]:other.toMap(),_S[2]:aStringList.$m((e)=> _0.ea(e)).$l,_S[3]:aOtherList.$m((e)=> e.toMap()).$l,}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(baseValue: m.$c(_S[0]) ?  _0.da(m[_S[0]], _8) as _8 : 0,other: m.$c(_S[1]) ? $Other.fromMap((m[_S[1]]) as _1) : _V[0],aStringList: m.$c(_S[2]) ?  (m[_S[2]] as _9).$m((e)=> _0.da(e, _3) as _3).$l : _V[1],aOtherList: m.$c(_S[3]) ?  (m[_S[3]] as _9).$m((e)=>$Other.fromMap((e) as _1)).$l : _V[2],);}
  _6 copyWith({_8? baseValue,_a resetBaseValue=_F,_8? deltaBaseValue,_7? other,_a resetOther=_F,_2? aStringList,_a resetAStringList=_F,_2? appendAStringList,_2? removeAStringList,_b? aOtherList,_a resetAOtherList=_F,_b? appendAOtherList,_b? removeAOtherList,})=>_6(baseValue: deltaBaseValue!=null?(baseValue??_H.baseValue)+deltaBaseValue:resetBaseValue?0:(baseValue??_H.baseValue),other: resetOther?_V[0]:(other??_H.other),aStringList: ((resetAStringList?_V[1]:(aStringList??_H.aStringList)) as _2).$u(appendAStringList,removeAStringList),aOtherList: ((resetAOtherList?_V[2]:(aOtherList??_H.aOtherList)) as _b).$u(appendAOtherList,removeAOtherList),);
  static Map<String, dynamic> get schema=>{_S[4]:_S[5],_S[6]:{_S[0]:{_S[4]:_S[7],_S[8]:_S[9],},_S[1]:{...$Other.schema,_S[8]:_S[10],},_S[2]:{_S[4]:_S[11],_S[12]:{_S[4]:_S[13],},_S[8]:_S[14],},_S[3]:{_S[4]:_S[11],_S[12]:{...$Other.schema,},_S[8]:_S[15],},},_S[16]:[_S[0],_S[1],_S[2],_S[3]],_S[17]:_F};
}
extension $Other on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{_S[18]:_0.ea(name),'age':_0.ea(age),}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(name: m.$c(_S[18]) ?  _0.da(m[_S[18]], _3) as _3 : "",age: m.$c('age') ?  _0.da(m['age'], _5) as _5 : 0,);}
  _7 copyWith({_3? name,_a resetName=_F,_5? age,_a resetAge=_F,_5? deltaAge,})=>_7(name: resetName?"":(name??_H.name),age: deltaAge!=null?(age??_H.age)+deltaAge:resetAge?0:(age??_H.age),);
  static Map<String, dynamic> get schema=>{_S[4]:_S[5],_S[6]:{_S[18]:{_S[4]:_S[13],_S[8]:_S[19],},'age':{_S[4]:_S[20],_S[8]:_S[21],},},_S[16]:[_S[18],'age'],_S[17]:_F};
}

