// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=A;typedef _7=B;typedef _8=C;typedef _9=D;typedef _a=bool;typedef _b=List<Object>;typedef _c=Artifact;typedef _d=Flag;typedef _e=List<$AFld>;typedef _f=List<$AMth>;typedef _g=MethodParameters;typedef _h=void;typedef _i=Start;typedef _j=$AClass;typedef _k=Object;typedef _l=AInterface;typedef _m=AMixin;typedef _n=$AClass<A>;typedef _o=$AClass<B>;typedef _p=$AClass<C>;typedef _q=$AClass<D>;typedef _r=List<dynamic>;
const _2 _S=['This is A','Basic Flag 42','This is D'];const _r _V=[];const _a _T=true;const _a _F=false;const _5 _ = 0;
extension $A on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{'a':_0.ea(a),}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromYaml(String j)=>fromMap(_0.v(j));
  static _6 fromToml(String j)=>fromMap(_0.t(j));
  static _6 fromProperties(String j)=>fromMap(_0.g(j));
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(a: m.$c('a') ?  _0.da(m['a'], _5) as _5 : 42,);}
  _6 copyWith({_5? a,_a resetA=_F,_5? deltaA,})=>_6(a: deltaA!=null?(a??_H.a)+deltaA:resetA?42:(a??_H.a),);
  static _6 get newInstance=>_6();
  static _b get $annotations {_;return[_c(generateSchema: _F,compression: _T,),_d(name: _S[0],),];}
  static _e get $fields{_;return[$AFld<_6, _5>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[_d(name: _S[1],),],),];}
  static _f get $methods {_;return[$AMth<_6, _h>('foo',(i, p)=>i.foo(),[],{},[_d(name: _S[1],),_i(),],),$AMth<_6, _h>('bar',(i, p)=>i.bar(),[],{},[],),];}
}
extension $B on _7{
  _7 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{'a':_0.ea(a),}.$nn;}
  static _7 fromJson(String j)=>fromMap(_0.o(j));
  static _7 fromYaml(String j)=>fromMap(_0.v(j));
  static _7 fromToml(String j)=>fromMap(_0.t(j));
  static _7 fromProperties(String j)=>fromMap(_0.g(j));
  static _7 fromMap(_1 r){_;_1 m=r.$nn;return _7(a: m.$c('a') ?  _0.da(m['a'], _5) as _5 : 42,);}
  _7 copyWith({_5? a,_a resetA=_F,_5? deltaA,})=>_7(a: deltaA!=null?(a??_H.a)+deltaA:resetA?42:(a??_H.a),);
  static _7 get newInstance=>_7();
  static _b get $annotations {_;return[_c(generateSchema: _F,compression: _T,),];}
  static _e get $fields{_;return[$AFld<_7, _5>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[],),];}
  static _f get $methods {_;return[];}
}
extension $C on _8{
  _8 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{'a':_0.ea(a),}.$nn;}
  static _8 fromJson(String j)=>fromMap(_0.o(j));
  static _8 fromYaml(String j)=>fromMap(_0.v(j));
  static _8 fromToml(String j)=>fromMap(_0.t(j));
  static _8 fromProperties(String j)=>fromMap(_0.g(j));
  static _8 fromMap(_1 r){_;_1 m=r.$nn;return _8(a: m.$c('a') ?  _0.da(m['a'], _5) as _5 : 42,);}
  _8 copyWith({_5? a,_a resetA=_F,_5? deltaA,})=>_8(a: deltaA!=null?(a??_H.a)+deltaA:resetA?42:(a??_H.a),);
  static _8 get newInstance=>_8();
  static _b get $annotations {_;return[_d(name: _S[1],),_c(generateSchema: _F,compression: _T,),];}
  static _e get $fields{_;return[$AFld<_8, _5>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[],),];}
  static _f get $methods {_;return[];}
}
extension $D on _9{
  _9 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _3 toYaml()=>_0.y(toMap);
  _3 toToml()=>_0.u(toMap);
  _3 toXml({bool pretty=_F})=>_0.z(pretty,toMap);
  _3 toProperties()=>_0.h(toMap);
  _1 toMap(){_;return <_3, _4>{'a':_0.ea(a),}.$nn;}
  static _9 fromJson(String j)=>fromMap(_0.o(j));
  static _9 fromYaml(String j)=>fromMap(_0.v(j));
  static _9 fromToml(String j)=>fromMap(_0.t(j));
  static _9 fromProperties(String j)=>fromMap(_0.g(j));
  static _9 fromMap(_1 r){_;_1 m=r.$nn;return _9(a: m.$c('a') ?  _0.da(m['a'], _5) as _5 : 42,);}
  _9 copyWith({_5? a,_a resetA=_F,_5? deltaA,})=>_9(a: deltaA!=null?(a??_H.a)+deltaA:resetA?42:(a??_H.a),);
  static _9 get newInstance=>_9();
  static _b get $annotations {_;return[_c(generateSchema: _F,compression: _T,),_d(name: _S[2],),_d(name: _S[1],),];}
  static _e get $fields{_;return[$AFld<_9, _5>('a',(i)=>i.a,(i,v)=>i.copyWith(a:v),[],),];}
  static _f get $methods {_;return[$AMth<_9, _h>('ass',(i, p)=>i.ass(),[],{},[_i(),],),$AMth<_9, _h>('bad',(i, p)=>i.bad(),[],{},[_i(),],),];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _6 ||v == _7 ||v == _8 ||v == _9 ;
Map<Type,_j> get $artifactMirror => {_6:$AClass<A>($A.$annotations,$A.$fields,$A.$methods,()=>$A.newInstance,_k,[_l],[_m],),_7:$AClass<B>($B.$annotations,$B.$fields,$B.$methods,()=>$B.newInstance,_k,[],[],),_8:$AClass<C>($C.$annotations,$C.$fields,$C.$methods,()=>$C.newInstance,_k,[],[],),_9:$AClass<D>($D.$annotations,$D.$fields,$D.$methods,()=>$D.newInstance,_k,[],[],),};
T $constructArtifact<T>() => T==_6 ?$A.newInstance as T :T==_7 ?$B.newInstance as T :T==_8 ?$C.newInstance as T :T==_9 ?$D.newInstance as T : throw Exception();
_1 $artifactToMap(Object o)=>o is _6 ?o.toMap():o is _7 ?o.toMap():o is _8 ?o.toMap():o is _9 ?o.toMap():throw Exception();
T $artifactFromMap<T>(_1 m)=>T==_6 ?$A.fromMap(m) as T:T==_7 ?$B.fromMap(m) as T:T==_8 ?$C.fromMap(m) as T:T==_9 ?$D.fromMap(m) as T: throw Exception();
