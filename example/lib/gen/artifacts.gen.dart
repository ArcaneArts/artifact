// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "dart:core";import "package:artifact/artifact.dart";

ArgumentError __x(String c,String f)=>ArgumentError('${'Missing required '}$c.$f');
const bool _T=true;const bool _F=false;int _ = ((){if(!ArtifactAccessor.$i('example')){ArtifactAccessor.$r('example',ArtifactAccessor(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $DoReflect on DoReflect{
  DoReflect get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{}.$nn;}
  static ArtifactModelImporter<DoReflect> get from=>ArtifactModelImporter<DoReflect>(fromMap);
  static DoReflect fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return DoReflect();}
  static DoReflect get newInstance=>DoReflect();
  ArtifactMirror get $mirror{_;return ArtifactCodecUtil.m(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[];}
  static List<$AMth> get $methods {_;return[];}
}
extension $NoOp on NoOp{
  NoOp get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{}.$nn;}
  static ArtifactModelImporter<NoOp> get from=>ArtifactModelImporter<NoOp>(fromMap);
  static NoOp fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return NoOp();}
  static NoOp get newInstance=>NoOp();
  ArtifactMirror get $mirror{_;return ArtifactCodecUtil.m(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[];}
  static List<$AMth> get $methods {_;return[];}
}
extension $Person on Person{
  Person get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'firstName':ArtifactCodecUtil.ea(firstName),'lastName':ArtifactCodecUtil.ea(lastName),'dateOfBirth':ArtifactCodecUtil.ea(dateOfBirth),}.$nn;}
  static ArtifactModelImporter<Person> get from=>ArtifactModelImporter<Person>(fromMap);
  static Person fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return Person(firstName: m.$c('firstName')? ArtifactCodecUtil.da(m['firstName'], String) as String:throw __x('Person','firstName'),lastName: m.$c('lastName')? ArtifactCodecUtil.da(m['lastName'], String) as String:throw __x('Person','lastName'),dateOfBirth: m.$c('dateOfBirth') ?  ArtifactCodecUtil.da(m['dateOfBirth'], DateTime) as DateTime? : null,);}
  Person copyWith({String? firstName,String? lastName,DateTime? dateOfBirth,bool deleteDateOfBirth=_F,})=>Person(firstName: firstName??_H.firstName,lastName: lastName??_H.lastName,dateOfBirth: deleteDateOfBirth?null:(dateOfBirth??_H.dateOfBirth),);
  static Person get newInstance=>Person(firstName: '',lastName: '',);
  ArtifactMirror get $mirror{_;return ArtifactCodecUtil.m(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[$AFld<Person, String>('firstName',(i)=>i.firstName,(i,v)=>i.copyWith(firstName:v),[],),$AFld<Person, String>('lastName',(i)=>i.lastName,(i,v)=>i.copyWith(lastName:v),[DoReflect(),NoRelfect(),],),$AFld<Person, DateTime?>('dateOfBirth',(i)=>i.dateOfBirth,(i,v)=>i.copyWith(dateOfBirth:v),[DoReflect(),],),];}
  static List<$AMth> get $methods {_;return[$AMth<Person, String>('toString',(i, p)=>i.toString(),[],{},[],),];}
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == DoReflect ||v == NoOp ||v == Person ;
Map<Type,$AClass> get $artifactMirror => {DoReflect:$AClass<DoReflect>($DoReflect.$annotations,$DoReflect.$fields,$DoReflect.$methods,()=>$DoReflect.newInstance,Object,[],[],),NoOp:$AClass<NoOp>($NoOp.$annotations,$NoOp.$fields,$NoOp.$methods,()=>$NoOp.newInstance,Object,[],[],),Person:$AClass<Person>($Person.$annotations,$Person.$fields,$Person.$methods,()=>$Person.newInstance,Object,[],[],),};
T $constructArtifact<T>() => T==DoReflect ?$DoReflect.newInstance as T :T==NoOp ?$NoOp.newInstance as T :T==Person ?$Person.newInstance as T : throw Exception();
Map<String,dynamic> $artifactToMap(Object o)=>o is DoReflect ?o.toMap():o is NoOp ?o.toMap():o is Person ?o.toMap():throw Exception();
T $artifactFromMap<T>(Map<String,dynamic> m)=>T==DoReflect ?$DoReflect.fromMap(m) as T:T==NoOp ?$NoOp.fromMap(m) as T:T==Person ?$Person.fromMap(m) as T:throw Exception();
