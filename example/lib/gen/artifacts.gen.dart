// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "dart:core";import "package:artifact/artifact.dart";
typedef _0=ArtifactCodecUtil;typedef _1=ArtifactDataUtil;typedef _2=ArtifactSecurityUtil;typedef _3=ArtifactReflection;typedef _4=ArtifactMirror;typedef _5=Map<String,dynamic>;typedef _6=List<String>;typedef _7=String;typedef _8=dynamic;typedef _9=int;typedef _a=ArtifactModelExporter;typedef _b=ArgumentError;typedef _c=Exception;typedef _d=Person;typedef _e=ArtifactModelImporter<Person>;typedef _f=DateTime;typedef _g=bool;typedef _h=List<Object>;typedef _i=Property;typedef _j=Artifact;typedef _k=List<$AFld>;typedef _l=List<$AMth>;typedef _m=MethodParameters;typedef _n=ArtifactAccessor;typedef _o=$AClass;typedef _p=Object;typedef _q=$AClass<Person>;typedef _r=List<dynamic>;
_b __x(_7 c,_7 f)=>_b('${_S[5]}$c.$f');
const _6 _S=['firstName','lastName','dateOfBirth','Person','example','Missing required '];const _r _V=[];const _g _T=true;const _g _F=false;_9 _ = ((){if(!_n.$i(_S[4])){_n.$r(_S[4],_n(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $Person on _d{
  _d get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[0]:_0.ea(firstName),_S[1]:_0.ea(lastName),_S[2]:_0.ea(dateOfBirth),}.$nn;}
  static _e get from=>_e(fromMap);
  static _d fromMap(_5 r){_;_5 m=r.$nn;return _d(firstName: m.$c(_S[0])? _0.da(m[_S[0]], _7) as _7:throw __x(_S[3],_S[0]),lastName: m.$c(_S[1]) ?  _0.da(m[_S[1]], _7) as _7? : null,dateOfBirth: m.$c(_S[2]) ?  _0.da(m[_S[2]], _f) as _f? : null,);}
  _d copyWith({_7? firstName,_7? lastName,_g deleteLastName=_F,_f? dateOfBirth,_g deleteDateOfBirth=_F,})=>_d(firstName: firstName??_H.firstName,lastName: deleteLastName?null:(lastName??_H.lastName),dateOfBirth: deleteDateOfBirth?null:(dateOfBirth??_H.dateOfBirth),);
  static _d get newInstance=>_d(firstName: '',);
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _h get $annotations {_;return[_i(),_j(generateSchema: _F,compression: _T,reflection: _T),];}
  static _k get $fields{_;return[$AFld<_d, _7>(_S[0],(i)=>i.firstName,(i,v)=>i.copyWith(firstName:v),[_i(),],),$AFld<_d, _7?>(_S[1],(i)=>i.lastName,(i,v)=>i.copyWith(lastName:v),[_i(),],),$AFld<_d, _f?>(_S[2],(i)=>i.dateOfBirth,(i,v)=>i.copyWith(dateOfBirth:v),[_i(),],),];}
  static _l get $methods {_;return[];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _d ;
Map<Type,_o> get $artifactMirror => {_d:$AClass<Person>($Person.$annotations,$Person.$fields,$Person.$methods,()=>$Person.newInstance,_p,[],[],),};
T $constructArtifact<T>() => T==_d ?$Person.newInstance as T : throw _c();
_5 $artifactToMap(Object o)=>o is _d ?o.toMap():throw _c();
T $artifactFromMap<T>(_5 m)=>T==_d ?$Person.fromMap(m) as T:throw _c();
