// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "dart:core";import "package:artifact/artifact.dart";
typedef _0=ArtifactCodecUtil;typedef _1=ArtifactMirror;typedef _2=Map<String,dynamic>;typedef _3=List<String>;typedef _4=String;typedef _5=dynamic;typedef _6=int;typedef _7=ArtifactModelExporter;typedef _8=ArgumentError;typedef _9=Exception;typedef _a=Person;typedef _b=ArtifactModelImporter<Person>;typedef _c=DateTime;typedef _d=bool;typedef _e=List<Object>;typedef _f=List<$AFld>;typedef _g=SomeAnnotation;typedef _h=List<$AMth>;typedef _i=MethodParameters;typedef _j=ArtifactAccessor;typedef _k=$AClass;typedef _l=Object;typedef _m=$AClass<Person>;typedef _n=List<dynamic>;
_8 __x(_4 c,_4 f)=>_8('${_S[6]}$c.$f');
const _3 _S=['firstName','lastName','dateOfBirth','Person','toString','example','Missing required '];const _n _V=[];const _d _T=true;const _d _F=false;_6 _ = ((){if(!_j.$i(_S[5])){_j.$r(_S[5],_j(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $Person on _a{
  _a get _H=>this;
  _7 get to=>_7(toMap);
  _2 toMap(){_;return<_4,_5>{_S[0]:_0.ea(firstName),_S[1]:_0.ea(lastName),_S[2]:_0.ea(dateOfBirth),}.$nn;}
  static _b get from=>_b(fromMap);
  static _a fromMap(_2 r){_;_2 m=r.$nn;return _a(firstName: m.$c(_S[0])? _0.da(m[_S[0]], _4) as _4:throw __x(_S[3],_S[0]),lastName: m.$c(_S[1])? _0.da(m[_S[1]], _4) as _4:throw __x(_S[3],_S[1]),dateOfBirth: m.$c(_S[2]) ?  _0.da(m[_S[2]], _c) as _c? : null,);}
  _a copyWith({_4? firstName,_4? lastName,_c? dateOfBirth,_d deleteDateOfBirth=_F,})=>_a(firstName: firstName??_H.firstName,lastName: lastName??_H.lastName,dateOfBirth: deleteDateOfBirth?null:(dateOfBirth??_H.dateOfBirth),);
  static _a get newInstance=>_a(firstName: '',lastName: '',);
  _1 get $mirror{_;return _0.m(_H)!;}
  static _e get $annotations {_;return[];}
  static _f get $fields{_;return[$AFld<_a, _4>(_S[0],(i)=>i.firstName,(i,v)=>i.copyWith(firstName:v),[_g(thing: _F,),],),$AFld<_a, _4>(_S[1],(i)=>i.lastName,(i,v)=>i.copyWith(lastName:v),[_g(thing: _F,),],),$AFld<_a, _c?>(_S[2],(i)=>i.dateOfBirth,(i,v)=>i.copyWith(dateOfBirth:v),[_g(thing: _F,),],),];}
  static _h get $methods {_;return[$AMth<_a, _4>(_S[4],(i, p)=>i.toString(),[],{},[_g(thing: _F,),],),];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _a ;
Map<Type,_k> get $artifactMirror => {_a:$AClass<Person>($Person.$annotations,$Person.$fields,$Person.$methods,()=>$Person.newInstance,_l,[],[],),};
T $constructArtifact<T>() => T==_a ?$Person.newInstance as T : throw _9();
_2 $artifactToMap(Object o)=>o is _a ?o.toMap():throw _9();
T $artifactFromMap<T>(_2 m)=>T==_a ?$Person.fromMap(m) as T:throw _9();
