// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:artifact/artifact.dart";import "package:artifact/events.dart";

const bool _T=true;const bool _F=false;int _ = ((){if(!ArtifactAccessor.$i('example')){ArtifactAccessor.$r('example',ArtifactAccessor(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}
return 0;})();
extension $SomeFunctionalThing on SomeFunctionalThing{
  SomeFunctionalThing get _H=>this;
  String toJson({bool pretty=_F})=>ArtifactCodecUtil.j(pretty, toMap);
  String toYaml()=>ArtifactCodecUtil.y(toMap);
  String toToml()=>ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty=_F})=>ArtifactCodecUtil.z(pretty,toMap);
  String toProperties()=>ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap(){_;return <String, dynamic>{}.$nn;}
  static SomeFunctionalThing fromJson(String j)=>fromMap(ArtifactCodecUtil.o(j));
  static SomeFunctionalThing fromYaml(String j)=>fromMap(ArtifactCodecUtil.v(j));
  static SomeFunctionalThing fromToml(String j)=>fromMap(ArtifactCodecUtil.t(j));
  static SomeFunctionalThing fromProperties(String j)=>fromMap(ArtifactCodecUtil.g(j));
  static SomeFunctionalThing fromMap(Map<String, dynamic> r){_;Map<String, dynamic> m=r.$nn;return SomeFunctionalThing();}
  static SomeFunctionalThing get newInstance=>SomeFunctionalThing();
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[];}
  static List<$AMth> get $methods {_;return[$AMth<SomeFunctionalThing, void>('on',(i, p)=>i.on(p.o<DerpEvent>(0),),[DerpEvent,],{},[EventHandler(ignoreCancelled: _F,priority: EventPriority.normal,),],),];}
}
extension $SomePriorityThing on SomePriorityThing{
  SomePriorityThing get _H=>this;
  String toJson({bool pretty=_F})=>ArtifactCodecUtil.j(pretty, toMap);
  String toYaml()=>ArtifactCodecUtil.y(toMap);
  String toToml()=>ArtifactCodecUtil.u(toMap);
  String toXml({bool pretty=_F})=>ArtifactCodecUtil.z(pretty,toMap);
  String toProperties()=>ArtifactCodecUtil.h(toMap);
  Map<String, dynamic> toMap(){_;return <String, dynamic>{}.$nn;}
  static SomePriorityThing fromJson(String j)=>fromMap(ArtifactCodecUtil.o(j));
  static SomePriorityThing fromYaml(String j)=>fromMap(ArtifactCodecUtil.v(j));
  static SomePriorityThing fromToml(String j)=>fromMap(ArtifactCodecUtil.t(j));
  static SomePriorityThing fromProperties(String j)=>fromMap(ArtifactCodecUtil.g(j));
  static SomePriorityThing fromMap(Map<String, dynamic> r){_;Map<String, dynamic> m=r.$nn;return SomePriorityThing();}
  static SomePriorityThing get newInstance=>SomePriorityThing();
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[];}
  static List<$AMth> get $methods {_;return[$AMth<SomePriorityThing, void>('on',(i, p)=>i.on(p.o<DerpEvent>(0),),[DerpEvent,],{},[EventHandler(ignoreCancelled: _T,priority: EventPriority.high,),],),];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == SomeFunctionalThing ||v == SomePriorityThing ;
Map<Type,$AClass> get $artifactMirror => {SomeFunctionalThing:$AClass<SomeFunctionalThing>($SomeFunctionalThing.$annotations,$SomeFunctionalThing.$fields,$SomeFunctionalThing.$methods,()=>$SomeFunctionalThing.newInstance,Object,[],[],),SomePriorityThing:$AClass<SomePriorityThing>($SomePriorityThing.$annotations,$SomePriorityThing.$fields,$SomePriorityThing.$methods,()=>$SomePriorityThing.newInstance,Object,[],[],),};
T $constructArtifact<T>() => T==SomeFunctionalThing ?$SomeFunctionalThing.newInstance as T :T==SomePriorityThing ?$SomePriorityThing.newInstance as T : throw Exception();
Map<String, dynamic> $artifactToMap(Object o)=>o is SomeFunctionalThing ?o.toMap():o is SomePriorityThing ?o.toMap():throw Exception();
T $artifactFromMap<T>(Map<String, dynamic> m)=>T==SomeFunctionalThing ?$SomeFunctionalThing.fromMap(m) as T:T==SomePriorityThing ?$SomePriorityThing.fromMap(m) as T: throw Exception();
