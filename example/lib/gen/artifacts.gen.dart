// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String, dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=User;typedef _7=ArgumentError;typedef _8=bool;typedef _9=List<dynamic>;
const _2 _S=['Missing required User."x" in map '];const _9 _V=[];const _8 _T=true;const _8 _F=false;const _5 _ = 0;
extension $User on _6{
  _6 get _H=>this;
  _3 toJson({bool pretty=_F})=>_0.j(pretty, toMap);
  _1 toMap(){_;return <_3, _4>{'x':_0.ea(x),}.$nn;}
  static _6 fromJson(String j)=>fromMap(_0.o(j));
  static _6 fromMap(_1 r){_;_1 m=r.$nn;return _6(x: m.$c('x')? _0.da(m['x'], _5) as _5:(throw _7('${_S[0]}$m.')),);}
  _6 copyWith({_5? x,_5? deltaX,})=>_6(x: deltaX!=null?(x??_H.x)+deltaX:x??_H.x,);
}

