// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "dart:core";import "package:artifact/artifact.dart";
typedef _0=ArtifactCodecUtil;typedef _1=ArtifactDataUtil;typedef _2=ArtifactSecurityUtil;typedef _3=ArtifactReflection;typedef _4=ArtifactMirror;typedef _5=Map<String,dynamic>;typedef _6=List<String>;typedef _7=String;typedef _8=dynamic;typedef _9=int;typedef _a=ArtifactModelExporter;typedef _b=ArgumentError;typedef _c=Exception;typedef _d=Holder;typedef _e=Meta;typedef _f=AMeta;typedef _g=BMeta;typedef _h=MapEntry;typedef _i=MapEntry<String, AMeta>;typedef _j=MapEntry<String, BMeta>;typedef _k=ArtifactModelImporter<Holder>;typedef _l=Map<String, AMeta>;typedef _m=bool;typedef _n=Map<String, BMeta>;typedef _o=List<Object>;typedef _p=Artifact;typedef _q=List<$AFld>;typedef _r=$AT<Map<String, AMeta>>;typedef _s=$AT<String>;typedef _t=$AT<AMeta>;typedef _u=$AT<Map<String, BMeta>>;typedef _v=$AT<BMeta>;typedef _w=List<$AMth>;typedef _x=MethodParameters;typedef _y=ArtifactModelImporter<Meta>;typedef _z=ArtifactModelImporter<AMeta>;typedef _10=$AT<int>;typedef _11=ArtifactModelImporter<BMeta>;typedef _12=ArtifactAccessor;typedef _13=$AClass;typedef _14=Object;typedef _15=$AClass<Holder>;typedef _16=$AT<Holder>;typedef _17=$AClass<Meta>;typedef _18=$AT<Meta>;typedef _19=$AClass<AMeta>;typedef _1a=$AClass<BMeta>;typedef _1b=List<dynamic>;
_b __x(_7 c,_7 f)=>_b('${_S[6]}$c.$f');
const _6 _S=['aMetas','bMetas','_subclass_Meta','AMeta','BMeta','example','Missing required '];const _1b _V=[<_7,_f>{},<_7,_g>{},"hello"];const _m _T=true;const _m _F=false;_9 _ = ((){if(!_12.$i(_S[5])){_12.$r(_S[5],_12(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $Holder on _d{
  _d get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[0]:aMetas.$m((k,v)=>_h(k, v.toMap())),_S[1]:bMetas.$m((k,v)=>_h(k, v.toMap())),}.$nn;}
  static _k get from=>_k(fromMap);
  static _d fromMap(_5 r){_;_5 m=r.$nn;return _d(aMetas: m.$c(_S[0]) ?  _1.fe((m[_S[0]] as Map).$e.$m((e)=>_i(e.key,$AMeta.fromMap((e.value) as Map<String, dynamic>)))) : _V[0],bMetas: m.$c(_S[1]) ?  _1.fe((m[_S[1]] as Map).$e.$m((e)=>_j(e.key,$BMeta.fromMap((e.value) as Map<String, dynamic>)))) : _V[1],);}
  _d copyWith({_l? aMetas,_m resetAMetas=_F,_n? bMetas,_m resetBMetas=_F,})=>_d(aMetas: resetAMetas?_V[0]:(aMetas??_H.aMetas),bMetas: resetBMetas?_V[1]:(bMetas??_H.bMetas),);
  static _d get newInstance=>_d();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _o get $annotations {_;return[_p(generateSchema: _F,compression: _T,reflection: _T),];}
  static _q get $fields{_;return[$AFld<_d, Map<String, AMeta>>(_S[0],(i)=>i.aMetas,(i,v)=>i.copyWith(aMetas:v),[],_r([_s(),_t()]),),$AFld<_d, Map<String, BMeta>>(_S[1],(i)=>i.bMetas,(i,v)=>i.copyWith(bMetas:v),[],_u([_s(),_v()]),),];}
  static _w get $methods {_;return[];}
}
extension $Meta on _e{
  _e get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;if (_H is _f){return (_H as _f).toMap();}if (_H is _g){return (_H as _g).toMap();}return<_7,_8>{}.$nn;}
  static _y get from=>_y(fromMap);
  static _e fromMap(_5 r){_;_5 m=r.$nn;if(m.$c(_S[2])){String _I=m[_S[2]] as _7;if(_I==_S[3]){return $AMeta.fromMap(m);}if(_I==_S[4]){return $BMeta.fromMap(m);}}return _e();}
  static _e get newInstance=>_e();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _o get $annotations {_;return[_p(generateSchema: _F,compression: _T,reflection: _T),];}
  static _q get $fields{_;return[];}
  static _w get $methods {_;return[];}
}
extension $AMeta on _f{
  _f get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[2]: 'AMeta','a':_0.ea(a),}.$nn;}
  static _z get from=>_z(fromMap);
  static _f fromMap(_5 r){_;_5 m=r.$nn;return _f(a: m.$c('a') ?  _0.da(m['a'], _9) as _9 : 4,);}
  _f copyWith({_9? a,_m resetA=_F,_9? deltaA,})=>_f(a: deltaA!=null?(a??_H.a)+deltaA:resetA?4:(a??_H.a),);
  static _f get newInstance=>_f();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _o get $annotations {_;return[_p(generateSchema: _F,compression: _T,reflection: _T),];}
  static _q get $fields{_;return[$AFld<_f, int>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[],_10(),),];}
  static _w get $methods {_;return[];}
}
extension $BMeta on _g{
  _g get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[2]: 'BMeta','b':_0.ea(b),}.$nn;}
  static _11 get from=>_11(fromMap);
  static _g fromMap(_5 r){_;_5 m=r.$nn;return _g(b: m.$c('b') ?  _0.da(m['b'], _7) as _7 : _V[2],);}
  _g copyWith({_7? b,_m resetB=_F,})=>_g(b: resetB?_V[2]:(b??_H.b),);
  static _g get newInstance=>_g();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _o get $annotations {_;return[_p(generateSchema: _F,compression: _T,reflection: _T),];}
  static _q get $fields{_;return[$AFld<_g, String>('b',(i)=>i.b,(i,v)=>i.copyWith(b:v),[],_s(),),];}
  static _w get $methods {_;return[];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _d ||v == _e ||v == _f ||v == _g ;
Map<Type,_13> get $artifactMirror => {_d:$AClass<Holder>($Holder.$annotations,$Holder.$fields,$Holder.$methods,()=>$Holder.newInstance,_14,[],[],_16(),),_e:$AClass<Meta>($Meta.$annotations,$Meta.$fields,$Meta.$methods,()=>$Meta.newInstance,_14,[],[],_18(),),_f:$AClass<AMeta>($AMeta.$annotations,$AMeta.$fields,$AMeta.$methods,()=>$AMeta.newInstance,_e,[],[],_t(),),_g:$AClass<BMeta>($BMeta.$annotations,$BMeta.$fields,$BMeta.$methods,()=>$BMeta.newInstance,_e,[],[],_v(),),};
T $constructArtifact<T>() => T==_d ?$Holder.newInstance as T :T==_e ?$Meta.newInstance as T :T==_f ?$AMeta.newInstance as T :T==_g ?$BMeta.newInstance as T : throw _c();
_5 $artifactToMap(Object o)=>o is _d ?o.toMap():o is _e ?o.toMap():o is _f ?o.toMap():o is _g ?o.toMap():throw _c();
T $artifactFromMap<T>(_5 m)=>T==_d ?$Holder.fromMap(m) as T:T==_e ?$Meta.fromMap(m) as T:T==_f ?$AMeta.fromMap(m) as T:T==_g ?$BMeta.fromMap(m) as T:throw _c();
