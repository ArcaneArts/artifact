// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "dart:core";

const bool _T=true;const bool _F=false;const int _ = 0;
extension $Test on Test{
  Test get _H=>this;
  String toJson({bool pretty=_F})=>ArtifactCodecUtil.j(pretty, toMap);
  String toYaml()=>ArtifactCodecUtil.y(toMap);
  String toToml()=>ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty=_F})=>ArtifactCodecUtil.z(pretty,toMap);
  String toProperties()=>ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap(){_;return <String, dynamic>{'aString':ArtifactCodecUtil.ea(aString),'aInt':ArtifactCodecUtil.ea(aInt),'anEnum':anEnum.name,'aSub':aSub.toMap(),'subList':subList?.$m((e)=> e.toMap()).$l,'aSet':aSet.$m((e)=> ArtifactCodecUtil.ea(e)).$l,'m':aMap.$m((k,v)=>MapEntry('$k', ArtifactCodecUtil.ea(v))),}.$nn;}
  static Test fromJson(String j)=>fromMap(ArtifactCodecUtil.o(j));
  static Test fromYaml(String j)=>fromMap(ArtifactCodecUtil.v(j));
  static Test fromToml(String j)=>fromMap(ArtifactCodecUtil.t(j));
  static Test fromProperties(String j)=>fromMap(ArtifactCodecUtil.g(j));
  static Test fromMap(Map<String, dynamic> r){_;Map<String, dynamic> m=r.$nn;return Test(aString: m.$c('aString') ?  ArtifactCodecUtil.da(m['aString'], String) as String : 'default',aInt: m.$c('aInt')? ArtifactCodecUtil.da(m['aInt'], int) as int:(throw ArgumentError('${'Missing required Test."aInt" in map '}$m.')),anEnum: m.$c('anEnum')?ArtifactCodecUtil.e(AEnum.values, m['anEnum']) as AEnum:(throw ArgumentError('${'Missing required Test."anEnum" in map '}$m.')),aSub: m.$c('aSub')?$Sub.fromMap((m['aSub']) as Map<String, dynamic>):(throw ArgumentError('${'Missing required Test."aSub" in map '}$m.')),subList: m.$c('subList')? (m['subList'] as List).$m((e)=>$Sub.fromMap((e) as Map<String, dynamic>)).$l:(throw ArgumentError('${'Missing required Test."subList" in map '}$m.')),aSet: m.$c('aSet')? (m['aSet'] as List).$m((e)=> ArtifactCodecUtil.da(e, int) as int).$s:(throw ArgumentError('${'Missing required Test."aSet" in map '}$m.')),aMap: m.$c('m')? ArtifactCodecUtil.fe((m['m'] as Map).$e.$m((e)=>MapEntry<int, String>(ArtifactCodecUtil.p<int>(e.key), ArtifactCodecUtil.da(e.value, String) as String))):(throw ArgumentError('${'Missing required Test."aMap" in map '}$m.')),);}
  Test copyWith({String? aString,bool resetAString=_F,int? aInt,int? deltaAInt,AEnum? anEnum,Sub? aSub,List<Sub>? subList,List<Sub>? appendSubList,List<Sub>? removeSubList,Set<int>? aSet,Set<int>? appendASet,Set<int>? removeASet,Map<int, String>? aMap,})=>Test(aString: resetAString?'default':(aString??_H.aString),aInt: deltaAInt!=null?(aInt??_H.aInt)+deltaAInt:aInt??_H.aInt,anEnum: anEnum??_H.anEnum,aSub: aSub??_H.aSub,subList: (subList??_H.subList)?.$u(appendSubList,removeSubList),aSet: (aSet??_H.aSet).$u(appendASet,removeASet),aMap: aMap??_H.aMap,);
  static Test get newInstance=>Test(aInt: 0,anEnum: AEnum.values.first,aSub: $Sub.newInstance,subList: null,aSet: {},aMap: {},);
  static List<$AFld> get $fields {_;return [$AFld<Test, String>('aString',(i)=>i.aString,(i,v)=>i.copyWith(aString:v),),$AFld<Test, int>('aInt',(i)=>i.aInt,(i,v)=>i.copyWith(aInt:v),),$AFld<Test, AEnum>('anEnum',(i)=>i.anEnum,(i,v)=>i.copyWith(anEnum:v),),$AFld<Test, Sub>('aSub',(i)=>i.aSub,(i,v)=>i.copyWith(aSub:v),),$AFld<Test, List<Sub>?>('subList',(i)=>i.subList,(i,v)=>i.copyWith(subList:v),),$AFld<Test, Set<int>>('aSet',(i)=>i.aSet,(i,v)=>i.copyWith(aSet:v),),$AFld<Test, Map<int, String>>('aMap',(i)=>i.aMap,(i,v)=>i.copyWith(aMap:v),),];}
}
extension $Sub on Sub{
  Sub get _H=>this;
  String toJson({bool pretty=_F})=>ArtifactCodecUtil.j(pretty, toMap);
  String toYaml()=>ArtifactCodecUtil.y(toMap);
  String toToml()=>ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty=_F})=>ArtifactCodecUtil.z(pretty,toMap);
  String toProperties()=>ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap(){_;return <String, dynamic>{'value':ArtifactCodecUtil.ea(value),}.$nn;}
  static Sub fromJson(String j)=>fromMap(ArtifactCodecUtil.o(j));
  static Sub fromYaml(String j)=>fromMap(ArtifactCodecUtil.v(j));
  static Sub fromToml(String j)=>fromMap(ArtifactCodecUtil.t(j));
  static Sub fromProperties(String j)=>fromMap(ArtifactCodecUtil.g(j));
  static Sub fromMap(Map<String, dynamic> r){_;Map<String, dynamic> m=r.$nn;return Sub(value: m.$c('value') ?  ArtifactCodecUtil.da(m['value'], int) as int : 42,);}
  Sub copyWith({int? value,bool resetValue=_F,int? deltaValue,})=>Sub(value: deltaValue!=null?(value??_H.value)+deltaValue:resetValue?42:(value??_H.value),);
  static Sub get newInstance=>Sub();
  static List<$AFld> get $fields {_;return [$AFld<Sub, int>('value',(i)=>i.value,(i,v)=>i.copyWith(value:v),),];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == Test ||v == Sub ;
T $constructArtifact<T>() => T==Test ?$Test.newInstance as T :T==Sub ?$Sub.newInstance as T : throw Exception();
Map<String, dynamic> $artifactToMap(Object o)=>o is Test ?o.toMap():o is Sub ?o.toMap():throw Exception();
T $artifactFromMap<T>(Map<String, dynamic> m)=>T==Test ?$Test.fromMap(m) as T:T==Sub ?$Sub.fromMap(m) as T: throw Exception();
