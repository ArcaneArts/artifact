// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=HelloReflection;typedef _7=SubObject;typedef _8=List;typedef _9=bool;typedef _a=List<SubObject>;typedef _b=List<$AFld>;typedef _c=List<dynamic>;
const _2 _S=['desc','options'];const _c _V=["A sub object",<_3>["a", "b", "c"]];const _9 _T=true;const _9 _F=false;const _5 _ = 0;
extension $HelloReflection on HelloReflection{
  HelloReflection get _H=>this;
  String toJson({bool pretty=_F})=>ArtifactCodecUtil.j(pretty, toMap);
  String toYaml()=>ArtifactCodecUtil.y(toMap);
  String toToml()=>ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty=_F})=>ArtifactCodecUtil.z(pretty,toMap);
  String toProperties()=>ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap(){_;return <String, dynamic>{'name':ArtifactCodecUtil.ea(name),'age':ArtifactCodecUtil.ea(age),'subs':subs.$m((e)=> e.toMap()).$l,}.$nn;}
  static HelloReflection fromJson(String j)=>fromMap(ArtifactCodecUtil.o(j));
  static HelloReflection fromYaml(String j)=>fromMap(ArtifactCodecUtil.v(j));
  static HelloReflection fromToml(String j)=>fromMap(ArtifactCodecUtil.t(j));
  static HelloReflection fromProperties(String j)=>fromMap(ArtifactCodecUtil.g(j));
  static HelloReflection fromMap(Map<String, dynamic> r){_;Map<String, dynamic> m=r.$nn;return HelloReflection(name: m.$c('name') ?  ArtifactCodecUtil.da(m['name'], String) as String : "John Doe",age: m.$c('age') ?  ArtifactCodecUtil.da(m['age'], int) as int : 30,subs: m.$c('subs') ?  (m['subs'] as List).$m((e)=>$SubObject.fromMap((e) as Map<String, dynamic>)).$l : const [SubObject()],);}
  HelloReflection copyWith({String? name,bool resetName=_F,int? age,bool resetAge=_F,int? deltaAge,List<SubObject>? subs,bool resetSubs=_F,List<SubObject>? appendSubs,List<SubObject>? removeSubs,})=>HelloReflection(name: resetName?"John Doe":(name??_H.name),age: deltaAge!=null?(age??_H.age)+deltaAge:resetAge?30:(age??_H.age),subs: ((resetSubs?const [SubObject()]:(subs??_H.subs)) as List<SubObject>).$u(appendSubs,removeSubs),);
  static List<$AFld> get $fields {_;return [$AFld<HelloReflection, String>('name',(i)=>i.name,(i,v)=>i.copyWith(name:v),),$AFld<HelloReflection, int>('age',(i)=>i.age,(i,v)=>i.copyWith(age:v),),$AFld<HelloReflection, List<SubObject>>('subs',(i)=>i.subs,(i,v)=>i.copyWith(subs:v),),];}
}
extension $SubObject on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{_S[0]:_0.ea(desc),_S[1]:options.$m((e)=> _0.ea(e)).$l,}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromYaml(String j)=>fromMap(_0.v(j));
  static _7 fromToml(String j)=>fromMap(_0.t(j));
  static _7 fromProperties(String j)=>fromMap(_0.g(j));
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(desc: m.$c(_S[0]) ?  _0.da(m[_S[0]], _3) as _3 : _V[0],options: m.$c(_S[1]) ?  (m[_S[1]] as _8).$m((e)=> _0.da(e, _3) as _3).$l : _V[1],);}
  _7 copyWith({_3? desc,_9 resetDesc=_F,_2? options,_9 resetOptions=_F,_2? appendOptions,_2? removeOptions,})=>_7(desc: resetDesc?_V[0]:(desc??_H.desc),options: ((resetOptions?_V[1]:(options??_H.options)) as _2).$u(appendOptions,removeOptions),);
}

