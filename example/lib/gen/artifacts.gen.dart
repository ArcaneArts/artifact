// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "dart:core";import "package:artifact/artifact.dart";
typedef _0=ArtifactCodecUtil;typedef _1=ArtifactDataUtil;typedef _2=ArtifactSecurityUtil;typedef _3=ArtifactReflection;typedef _4=ArtifactMirror;typedef _5=Map<String,dynamic>;typedef _6=List<String>;typedef _7=String;typedef _8=dynamic;typedef _9=int;typedef _a=ArtifactModelExporter;typedef _b=ArgumentError;typedef _c=Exception;typedef _d=Holder;typedef _e=Meta;typedef _f=AMeta;typedef _g=BMeta;typedef _h=VectorValue;typedef _i=MapEntry;typedef _j=MapEntry<String, AMeta>;typedef _k=MapEntry<String, BMeta>;typedef _l=ArtifactModelImporter<Holder>;typedef _m=Map<String, AMeta>;typedef _n=bool;typedef _o=Map<String, BMeta>;typedef _p=List<Object>;typedef _q=Artifact;typedef _r=List<$AFld>;typedef _s=$AT<Map<String, AMeta>>;typedef _t=$AT<String>;typedef _u=$AT<AMeta>;typedef _v=$AT<Map<String, BMeta>>;typedef _w=$AT<BMeta>;typedef _x=List<$AMth>;typedef _y=MethodParameters;typedef _z=ArtifactModelImporter<Meta>;typedef _10=ArtifactModelImporter<AMeta>;typedef _11=$AT<int>;typedef _12=ArtifactModelImporter<BMeta>;typedef _13=ArtifactModelImporter<VectorValue>;typedef _14=double;typedef _15=List;typedef _16=List<double>;typedef _17=ArtifactAccessor;typedef _18=$AClass;typedef _19=Object;typedef _1a=$AClass<Holder>;typedef _1b=$AT<Holder>;typedef _1c=$AClass<Meta>;typedef _1d=$AT<Meta>;typedef _1e=$AClass<AMeta>;typedef _1f=$AClass<BMeta>;typedef _1g=List<dynamic>;
_b __x(_7 c,_7 f)=>_b('${_S[8]}$c.$f');
const _6 _S=['aMetas','bMetas','_subclass_Meta','AMeta','BMeta','magic\$type','vector','example','Missing required '];const _1g _V=[<_7,_f>{},<_7,_g>{},"hello","vector",<_14>[]];const _n _T=true;const _n _F=false;_9 _ = ((){if(!_17.$i(_S[7])){_17.$r(_S[7],_17(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $Holder on _d{
  _d get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[0]:aMetas.$m((k,v)=>_i(k, v.toMap())),_S[1]:bMetas.$m((k,v)=>_i(k, v.toMap())),}.$nn;}
  static _l get from=>_l(fromMap);
  static _d fromMap(_5 r){_;_5 m=r.$nn;return _d(aMetas: m.$c(_S[0]) ?  _1.fe((m[_S[0]] as Map).$e.$m((e)=>_j(e.key,$AMeta.fromMap((e.value) as Map<String, dynamic>)))) : _V[0],bMetas: m.$c(_S[1]) ?  _1.fe((m[_S[1]] as Map).$e.$m((e)=>_k(e.key,$BMeta.fromMap((e.value) as Map<String, dynamic>)))) : _V[1],);}
  _d copyWith({_m? aMetas,_n resetAMetas=_F,_o? bMetas,_n resetBMetas=_F,})=>_d(aMetas: resetAMetas?_V[0]:(aMetas??_H.aMetas),bMetas: resetBMetas?_V[1]:(bMetas??_H.bMetas),);
  static _d get newInstance=>_d();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _p get $annotations {_;return[_q(generateSchema: _F,compression: _T,reflection: _T),];}
  static _r get $fields{_;return[$AFld<_d, Map<String, AMeta>>(_S[0],(i)=>i.aMetas,(i,v)=>i.copyWith(aMetas:v),[],_s([_t(),_u()]),),$AFld<_d, Map<String, BMeta>>(_S[1],(i)=>i.bMetas,(i,v)=>i.copyWith(bMetas:v),[],_v([_t(),_w()]),),];}
  static _x get $methods {_;return[];}
}
extension $Meta on _e{
  _e get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;if (_H is _f){return (_H as _f).toMap();}if (_H is _g){return (_H as _g).toMap();}return<_7,_8>{}.$nn;}
  static _z get from=>_z(fromMap);
  static _e fromMap(_5 r){_;_5 m=r.$nn;if(m.$c(_S[2])){String _I=m[_S[2]] as _7;if(_I==_S[3]){return $AMeta.fromMap(m);}if(_I==_S[4]){return $BMeta.fromMap(m);}}return _e();}
  static _e get newInstance=>_e();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _p get $annotations {_;return[_q(generateSchema: _F,compression: _T,reflection: _T),];}
  static _r get $fields{_;return[];}
  static _x get $methods {_;return[];}
}
extension $AMeta on _f{
  _f get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[2]: 'AMeta','a':_0.ea(a),}.$nn;}
  static _10 get from=>_10(fromMap);
  static _f fromMap(_5 r){_;_5 m=r.$nn;return _f(a: m.$c('a') ?  _0.da(m['a'], _9) as _9 : 4,);}
  _f copyWith({_9? a,_n resetA=_F,_9? deltaA,})=>_f(a: deltaA!=null?(a??_H.a)+deltaA:resetA?4:(a??_H.a),);
  static _f get newInstance=>_f();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _p get $annotations {_;return[_q(generateSchema: _F,compression: _T,reflection: _T),];}
  static _r get $fields{_;return[$AFld<_f, int>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[],_11(),),];}
  static _x get $methods {_;return[];}
}
extension $BMeta on _g{
  _g get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[2]: 'BMeta','b':_0.ea(b),}.$nn;}
  static _12 get from=>_12(fromMap);
  static _g fromMap(_5 r){_;_5 m=r.$nn;return _g(b: m.$c('b') ?  _0.da(m['b'], _7) as _7 : _V[2],);}
  _g copyWith({_7? b,_n resetB=_F,})=>_g(b: resetB?_V[2]:(b??_H.b),);
  static _g get newInstance=>_g();
  _4 get $mirror{_;return _3.instanceOf(_H)!;}
  static _p get $annotations {_;return[_q(generateSchema: _F,compression: _T,reflection: _T),];}
  static _r get $fields{_;return[$AFld<_g, String>('b',(i)=>i.b,(i,v)=>i.copyWith(b:v),[],_t(),),];}
  static _x get $methods {_;return[];}
}
extension $VectorValue on _h{
  _h get _H=>this;
  _a get to=>_a(toMap);
  _5 toMap(){_;return<_7,_8>{_S[5]:_0.ea(magic$type),_S[6]:vector.$m((e)=> _0.ea(e)).$l,}.$nn;}
  static _13 get from=>_13(fromMap);
  static _h fromMap(_5 r){_;_5 m=r.$nn;return _h(magic$type: m.$c(_S[5]) ?  _0.da(m[_S[5]], _7) as _7 : _V[3],vector: m.$c(_S[6]) ?  (m[_S[6]] as _15).$m((e)=> _0.da(e, _14) as _14).$l : _V[4],);}
  _h copyWith({_7? magic$type,_n resetMagic$type=_F,_16? vector,_n resetVector=_F,_16? appendVector,_16? removeVector,})=>_h(magic$type: resetMagic$type?_V[3]:(magic$type??_H.magic$type),vector: ((resetVector?_V[4]:(vector??_H.vector)) as _16).$u(appendVector,removeVector),);
  static _h get newInstance=>_h();
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _d ||v == _e ||v == _f ||v == _g ||v == _h ;
Map<Type,_18> get $artifactMirror => {_d:$AClass<Holder>($Holder.$annotations,$Holder.$fields,$Holder.$methods,()=>$Holder.newInstance,_19,[],[],_1b(),),_e:$AClass<Meta>($Meta.$annotations,$Meta.$fields,$Meta.$methods,()=>$Meta.newInstance,_19,[],[],_1d(),),_f:$AClass<AMeta>($AMeta.$annotations,$AMeta.$fields,$AMeta.$methods,()=>$AMeta.newInstance,_e,[],[],_u(),),_g:$AClass<BMeta>($BMeta.$annotations,$BMeta.$fields,$BMeta.$methods,()=>$BMeta.newInstance,_e,[],[],_w(),),};
T $constructArtifact<T>() => T==_d ?$Holder.newInstance as T :T==_e ?$Meta.newInstance as T :T==_f ?$AMeta.newInstance as T :T==_g ?$BMeta.newInstance as T :T==_h ?$VectorValue.newInstance as T : throw _c();
_5 $artifactToMap(Object o)=>o is _d ?o.toMap():o is _e ?o.toMap():o is _f ?o.toMap():o is _g ?o.toMap():o is _h ?o.toMap():throw _c();
T $artifactFromMap<T>(_5 m)=>T==_d ?$Holder.fromMap(m) as T:T==_e ?$Meta.fromMap(m) as T:T==_f ?$AMeta.fromMap(m) as T:T==_g ?$BMeta.fromMap(m) as T:T==_h ?$VectorValue.fromMap(m) as T:throw _c();
