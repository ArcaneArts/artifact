// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:artifact/test_models/feature_models.dart";import "dart:core";import "package:artifact/artifact.dart";import "package:artifact/events.dart";

ArgumentError __x(String c,String f)=>ArgumentError('${'Missing required '}$c.$f');
const bool _T=true;const bool _F=false;int _ = ((){ArtifactCodecUtil.r(const [WeirdCodec()]);if(!ArtifactAccessor.$i('artifact')){ArtifactAccessor.$r('artifact',ArtifactAccessor(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $Person on Person{
  Person get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'name':ArtifactCodecUtil.ea(name),'subtitle':ArtifactCodecUtil.ea(subtitle),}.$nn;}
  static ArtifactModelImporter<Person> get from=>ArtifactModelImporter<Person>(fromMap);
  static Person fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return Person(name: m.$c('name')? ArtifactCodecUtil.da(m['name'], String) as String:throw __x('Person','name'),subtitle: m.$c('subtitle') ?  ArtifactCodecUtil.da(m['subtitle'], String) as String? : null,);}
  Person copyWith({String? name,String? subtitle,bool deleteSubtitle=_F,})=>Person(name: name??_H.name,subtitle: deleteSubtitle?null:(subtitle??_H.subtitle),);
  static Person get newInstance=>Person(name: '',);
  ArtifactMirror get $mirror{_;return ArtifactReflection.instanceOf(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T),attach<UiHint>(UiHint.classLevel),];}
  static List<$AFld> get $fields{_;return[$AFld<Person, String>('name',(i)=>i.name,(i,v)=>i.copyWith(name:v),[attach<UiHint>(UiHint.title),],$AT<String>(),),$AFld<Person, String?>('subtitle',(i)=>i.subtitle,(i,v)=>i.copyWith(subtitle:v),[attach<UiHint>(UiHint.subtitle),],$AT<String?>(),),];}
  static List<$AMth> get $methods {_;return[];}
}
extension $Animal on Animal{
  Animal get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;if (_H is Dog){return (_H as Dog).toMap();}return<String,dynamic>{'hp':ArtifactCodecUtil.ea(hp),}.$nn;}
  static ArtifactModelImporter<Animal> get from=>ArtifactModelImporter<Animal>(fromMap);
  static Animal fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;if(m.$c('_subclass_Animal')){String _I=m['_subclass_Animal'] as String;if(_I=='Dog'){return $Dog.fromMap(m);}}return Animal(hp: m.$c('hp') ?  ArtifactCodecUtil.da(m['hp'], int) as int : 10,);}
  Animal copyWith({int? hp,bool resetHp=_F,int? deltaHp,}){if (_H is Dog){return (_H as Dog).copyWith(hp: hp,resetHp:resetHp,deltaHp:deltaHp,);}return Animal(hp: deltaHp!=null?(hp??_H.hp)+deltaHp:resetHp?10:(hp??_H.hp),);}
  static Animal get newInstance=>Animal();
}
extension $Dog on Dog{
  Dog get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'_subclass_Animal': 'Dog','hp':ArtifactCodecUtil.ea(hp),'goodBoy':ArtifactCodecUtil.ea(goodBoy),}.$nn;}
  static ArtifactModelImporter<Dog> get from=>ArtifactModelImporter<Dog>(fromMap);
  static Dog fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return Dog(hp: m.$c('hp') ?  ArtifactCodecUtil.da(m['hp'], int) as int : 20,goodBoy: m.$c('goodBoy') ?  ArtifactCodecUtil.da(m['goodBoy'], bool) as bool : true,);}
  Dog copyWith({int? hp,bool resetHp=_F,int? deltaHp,bool? goodBoy,bool resetGoodBoy=_F,})=>Dog(hp: deltaHp!=null?(hp??_H.hp)+deltaHp:resetHp?20:(hp??_H.hp),goodBoy: resetGoodBoy?true:(goodBoy??_H.goodBoy),);
  static Dog get newInstance=>Dog();
}
extension $Zoo on Zoo{
  Zoo get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'animals':animals.$m((e)=> e.toMap()).$l,}.$nn;}
  static ArtifactModelImporter<Zoo> get from=>ArtifactModelImporter<Zoo>(fromMap);
  static Zoo fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return Zoo(animals: m.$c('animals') ?  (m['animals'] as List).$m((e)=>$Animal.fromMap((e) as Map<String, dynamic>)).$l : const [],);}
  Zoo copyWith({List<Animal>? animals,bool resetAnimals=_F,List<Animal>? appendAnimals,List<Animal>? removeAnimals,})=>Zoo(animals: ((resetAnimals?const <Animal>[]:(animals??_H.animals)) as List<Animal>).$u(appendAnimals,removeAnimals),);
  static Zoo get newInstance=>Zoo();
}
extension $ListenerModel on ListenerModel{
  ListenerModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'id':ArtifactCodecUtil.ea(id),}.$nn;}
  static ArtifactModelImporter<ListenerModel> get from=>ArtifactModelImporter<ListenerModel>(fromMap);
  static ListenerModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return ListenerModel(id: m.$c('id') ?  ArtifactCodecUtil.da(m['id'], int) as int : 0,);}
  ListenerModel copyWith({int? id,bool resetId=_F,int? deltaId,})=>ListenerModel(id: deltaId!=null?(id??_H.id)+deltaId:resetId?0:(id??_H.id),);
  static ListenerModel get newInstance=>ListenerModel();
  ArtifactMirror get $mirror{_;return ArtifactReflection.instanceOf(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T),];}
  static List<$AFld> get $fields{_;return[$AFld<ListenerModel, int>('id',(i)=>i.id,(i,v)=>i.copyWith(id:v),[],$AT<int>(),),];}
  static List<$AMth> get $methods {_;return[$AMth<ListenerModel, void>('onPing',(i, p)=>i.onPing(p.o<PingEvent>(0),),[PingEvent,],{},[EventHandler(priority: EventPriority.normal,ignoreCancelled: _T),],$AT<void>(),[$AT<PingEvent>(),],{},),];}
}
extension $FeatureModel on FeatureModel{
  FeatureModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'v':ArtifactCodecUtil.ea(value),'ratio':ArtifactCodecUtil.ea(ratio),'note':ArtifactCodecUtil.ea(note),'numbers':numbers.$m((e)=> ArtifactCodecUtil.ea(e)).$l,'tags':tags.$m((e)=> ArtifactCodecUtil.ea(e)).$l,'mood':mood.name,'weird':ArtifactCodecUtil.ea(weird),}.$nn;}
  static ArtifactModelImporter<FeatureModel> get from=>ArtifactModelImporter<FeatureModel>(fromMap);
  static FeatureModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return FeatureModel(value: m.$c('v') ?  ArtifactCodecUtil.da(m['v'], int) as int : 4,ratio: m.$c('ratio')? ArtifactCodecUtil.da(m['ratio'], double) as double:throw __x('FeatureModel','ratio'),note: m.$c('note') ?  ArtifactCodecUtil.da(m['note'], String) as String? : null,numbers: m.$c('numbers') ?  (m['numbers'] as List).$m((e)=> ArtifactCodecUtil.da(e, int) as int).$l : const <int>[],tags: m.$c('tags') ?  (m['tags'] as List).$m((e)=> ArtifactCodecUtil.da(e, String) as String).$s : const <String>{},mood: m.$c('mood') ? ArtifactDataUtil.e(Mood.values, m['mood']) as Mood : Mood.happy,weird: m.$c('weird') ?  ArtifactCodecUtil.da(m['weird'], Weird) as Weird : const Weird(7),);}
  FeatureModel copyWith({int? value,bool resetValue=_F,int? deltaValue,double? ratio,double? deltaRatio,String? note,bool deleteNote=_F,List<int>? numbers,bool resetNumbers=_F,List<int>? appendNumbers,List<int>? removeNumbers,Set<String>? tags,bool resetTags=_F,Set<String>? appendTags,Set<String>? removeTags,Mood? mood,bool resetMood=_F,Weird? weird,bool resetWeird=_F,})=>FeatureModel(value: deltaValue!=null?(value??_H.value)+deltaValue:resetValue?4:(value??_H.value),ratio: deltaRatio!=null?(ratio??_H.ratio)+deltaRatio:ratio??_H.ratio,note: deleteNote?null:(note??_H.note),numbers: ((resetNumbers?const <int>[]:(numbers??_H.numbers)) as List<int>).$u(appendNumbers,removeNumbers),tags: ((resetTags?const <String>{}:(tags??_H.tags)) as Set<String>).$u(appendTags,removeTags),mood: resetMood?Mood.happy:(mood??_H.mood),weird: resetWeird?const Weird(7):(weird??_H.weird),);
  static FeatureModel get newInstance=>FeatureModel(ratio: 0,);
}
extension $ReflectModel on ReflectModel{
  ReflectModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'value':ArtifactCodecUtil.ea(value),}.$nn;}
  static ArtifactModelImporter<ReflectModel> get from=>ArtifactModelImporter<ReflectModel>(fromMap);
  static ReflectModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return ReflectModel(value: m.$c('value') ?  ArtifactCodecUtil.da(m['value'], int) as int : 1,);}
  ReflectModel copyWith({int? value,bool resetValue=_F,int? deltaValue,})=>ReflectModel(value: deltaValue!=null?(value??_H.value)+deltaValue:resetValue?1:(value??_H.value),);
  static ReflectModel get newInstance=>ReflectModel();
  ArtifactMirror get $mirror{_;return ArtifactReflection.instanceOf(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T),];}
  static List<$AFld> get $fields{_;return[$AFld<ReflectModel, int>('value',(i)=>i.value,(i,v)=>i.copyWith(value:v),[],$AT<int>(),),];}
  static List<$AMth> get $methods {_;return[];}
}
extension $NullableReflectSubObject on NullableReflectSubObject{
  NullableReflectSubObject get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'value':ArtifactCodecUtil.ea(value),'anotherValue':ArtifactCodecUtil.ea(anotherValue),}.$nn;}
  static ArtifactModelImporter<NullableReflectSubObject> get from=>ArtifactModelImporter<NullableReflectSubObject>(fromMap);
  static NullableReflectSubObject fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return NullableReflectSubObject(value: m.$c('value') ?  ArtifactCodecUtil.da(m['value'], String) as String : "something",anotherValue: m.$c('anotherValue') ?  ArtifactCodecUtil.da(m['anotherValue'], int) as int : 42,);}
  NullableReflectSubObject copyWith({String? value,bool resetValue=_F,int? anotherValue,bool resetAnotherValue=_F,int? deltaAnotherValue,})=>NullableReflectSubObject(value: resetValue?"something":(value??_H.value),anotherValue: deltaAnotherValue!=null?(anotherValue??_H.anotherValue)+deltaAnotherValue:resetAnotherValue?42:(anotherValue??_H.anotherValue),);
  static NullableReflectSubObject get newInstance=>NullableReflectSubObject();
  ArtifactMirror get $mirror{_;return ArtifactReflection.instanceOf(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T),];}
  static List<$AFld> get $fields{_;return[$AFld<NullableReflectSubObject, String>('value',(i)=>i.value,(i,v)=>i.copyWith(value:v),[],$AT<String>(),),$AFld<NullableReflectSubObject, int>('anotherValue',(i)=>i.anotherValue,(i,v)=>i.copyWith(anotherValue:v),[],$AT<int>(),),];}
  static List<$AMth> get $methods {_;return[];}
}
extension $NullableReflectCollectionsModel on NullableReflectCollectionsModel{
  NullableReflectCollectionsModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'aListOfNullableStrings':aListOfNullableStrings.$m((e)=> ArtifactCodecUtil.ea(e)).$l,'aSetOfNullableStrings':aSetOfNullableStrings.$m((e)=> ArtifactCodecUtil.ea(e)).$l,'aListOfNullableSubObjects':aListOfNullableSubObjects.$m((e)=> e?.toMap()).$l,'aSetOfNullableSubObjects':aSetOfNullableSubObjects.$m((e)=> e?.toMap()).$l,'aMapOfStringToNullableString':aMapOfStringToNullableString.$m((k,v)=>MapEntry(k, ArtifactCodecUtil.ea(v))),'aMapOfStringToNullableSubObject':aMapOfStringToNullableSubObject.$m((k,v)=>MapEntry(k, v?.toMap())),}.$nn;}
  static ArtifactModelImporter<NullableReflectCollectionsModel> get from=>ArtifactModelImporter<NullableReflectCollectionsModel>(fromMap);
  static NullableReflectCollectionsModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return NullableReflectCollectionsModel(aListOfNullableStrings: m.$c('aListOfNullableStrings') ?  (m['aListOfNullableStrings'] as List).$m((e)=> ArtifactCodecUtil.da(e, String) as String?).$l : const <String?>[],aSetOfNullableStrings: m.$c('aSetOfNullableStrings') ?  (m['aSetOfNullableStrings'] as List).$m((e)=> ArtifactCodecUtil.da(e, String) as String?).$s : const <String?>{},aListOfNullableSubObjects: m.$c('aListOfNullableSubObjects') ?  (m['aListOfNullableSubObjects'] as List).$m((e)=>$NullableReflectSubObject.fromMap((e) as Map<String, dynamic>)).$l : const <NullableReflectSubObject?>[],aSetOfNullableSubObjects: m.$c('aSetOfNullableSubObjects') ?  (m['aSetOfNullableSubObjects'] as List).$m((e)=>$NullableReflectSubObject.fromMap((e) as Map<String, dynamic>)).$s : const <NullableReflectSubObject?>{},aMapOfStringToNullableString: m.$c('aMapOfStringToNullableString') ?  ArtifactDataUtil.fe((m['aMapOfStringToNullableString'] as Map).$e.$m((e)=>MapEntry<String, String?>(e.key, ArtifactCodecUtil.da(e.value, String) as String?))) : const <String, String?>{},aMapOfStringToNullableSubObject: m.$c('aMapOfStringToNullableSubObject') ?  ArtifactDataUtil.fe((m['aMapOfStringToNullableSubObject'] as Map).$e.$m((e)=>MapEntry<String, NullableReflectSubObject?>(e.key,$NullableReflectSubObject.fromMap((e.value) as Map<String, dynamic>)))) : const <String, NullableReflectSubObject?>{},);}
  NullableReflectCollectionsModel copyWith({List<String?>? aListOfNullableStrings,bool resetAListOfNullableStrings=_F,List<String?>? appendAListOfNullableStrings,List<String?>? removeAListOfNullableStrings,Set<String?>? aSetOfNullableStrings,bool resetASetOfNullableStrings=_F,Set<String?>? appendASetOfNullableStrings,Set<String?>? removeASetOfNullableStrings,List<NullableReflectSubObject?>? aListOfNullableSubObjects,bool resetAListOfNullableSubObjects=_F,List<NullableReflectSubObject?>? appendAListOfNullableSubObjects,List<NullableReflectSubObject?>? removeAListOfNullableSubObjects,Set<NullableReflectSubObject?>? aSetOfNullableSubObjects,bool resetASetOfNullableSubObjects=_F,Set<NullableReflectSubObject?>? appendASetOfNullableSubObjects,Set<NullableReflectSubObject?>? removeASetOfNullableSubObjects,Map<String, String?>? aMapOfStringToNullableString,bool resetAMapOfStringToNullableString=_F,Map<String, NullableReflectSubObject?>? aMapOfStringToNullableSubObject,bool resetAMapOfStringToNullableSubObject=_F,})=>NullableReflectCollectionsModel(aListOfNullableStrings: ((resetAListOfNullableStrings?const <String?>[]:(aListOfNullableStrings??_H.aListOfNullableStrings)) as List<String?>).$u(appendAListOfNullableStrings,removeAListOfNullableStrings),aSetOfNullableStrings: ((resetASetOfNullableStrings?const <String?>{}:(aSetOfNullableStrings??_H.aSetOfNullableStrings)) as Set<String?>).$u(appendASetOfNullableStrings,removeASetOfNullableStrings),aListOfNullableSubObjects: ((resetAListOfNullableSubObjects?const <NullableReflectSubObject?>[]:(aListOfNullableSubObjects??_H.aListOfNullableSubObjects)) as List<NullableReflectSubObject?>).$u(appendAListOfNullableSubObjects,removeAListOfNullableSubObjects),aSetOfNullableSubObjects: ((resetASetOfNullableSubObjects?const <NullableReflectSubObject?>{}:(aSetOfNullableSubObjects??_H.aSetOfNullableSubObjects)) as Set<NullableReflectSubObject?>).$u(appendASetOfNullableSubObjects,removeASetOfNullableSubObjects),aMapOfStringToNullableString: resetAMapOfStringToNullableString?const <String, String?>{}:(aMapOfStringToNullableString??_H.aMapOfStringToNullableString),aMapOfStringToNullableSubObject: resetAMapOfStringToNullableSubObject?const <String, NullableReflectSubObject?>{}:(aMapOfStringToNullableSubObject??_H.aMapOfStringToNullableSubObject),);
  static NullableReflectCollectionsModel get newInstance=>NullableReflectCollectionsModel();
  ArtifactMirror get $mirror{_;return ArtifactReflection.instanceOf(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T),];}
  static List<$AFld> get $fields{_;return[$AFld<NullableReflectCollectionsModel, List<String?>>('aListOfNullableStrings',(i)=>i.aListOfNullableStrings,(i,v)=>i.copyWith(aListOfNullableStrings:v),[],$AT<List<String?>>([$AT<String?>()]),),$AFld<NullableReflectCollectionsModel, Set<String?>>('aSetOfNullableStrings',(i)=>i.aSetOfNullableStrings,(i,v)=>i.copyWith(aSetOfNullableStrings:v),[],$AT<Set<String?>>([$AT<String?>()]),),$AFld<NullableReflectCollectionsModel, List<NullableReflectSubObject?>>('aListOfNullableSubObjects',(i)=>i.aListOfNullableSubObjects,(i,v)=>i.copyWith(aListOfNullableSubObjects:v),[],$AT<List<NullableReflectSubObject?>>([$AT<NullableReflectSubObject?>()]),),$AFld<NullableReflectCollectionsModel, Set<NullableReflectSubObject?>>('aSetOfNullableSubObjects',(i)=>i.aSetOfNullableSubObjects,(i,v)=>i.copyWith(aSetOfNullableSubObjects:v),[],$AT<Set<NullableReflectSubObject?>>([$AT<NullableReflectSubObject?>()]),),$AFld<NullableReflectCollectionsModel, Map<String, String?>>('aMapOfStringToNullableString',(i)=>i.aMapOfStringToNullableString,(i,v)=>i.copyWith(aMapOfStringToNullableString:v),[],$AT<Map<String, String?>>([$AT<String>(),$AT<String?>()]),),$AFld<NullableReflectCollectionsModel, Map<String, NullableReflectSubObject?>>('aMapOfStringToNullableSubObject',(i)=>i.aMapOfStringToNullableSubObject,(i,v)=>i.copyWith(aMapOfStringToNullableSubObject:v),[],$AT<Map<String, NullableReflectSubObject?>>([$AT<String>(),$AT<NullableReflectSubObject?>()]),),];}
  static List<$AMth> get $methods {_;return[];}
}
extension $SchemaModel on SchemaModel{
  SchemaModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'identifier':ArtifactCodecUtil.ea(id),'enabled':ArtifactCodecUtil.ea(enabled),'samples':samples.$m((e)=> ArtifactCodecUtil.ea(e)).$l,}.$nn;}
  static ArtifactModelImporter<SchemaModel> get from=>ArtifactModelImporter<SchemaModel>(fromMap);
  static SchemaModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return SchemaModel(id: m.$c('identifier') ?  ArtifactCodecUtil.da(m['identifier'], int) as int : 1,enabled: m.$c('enabled') ?  ArtifactCodecUtil.da(m['enabled'], bool) as bool : true,samples: m.$c('samples') ?  (m['samples'] as List).$m((e)=> ArtifactCodecUtil.da(e, int) as int).$l : const <int>[1, 2],);}
  SchemaModel copyWith({int? id,bool resetId=_F,int? deltaId,bool? enabled,bool resetEnabled=_F,List<int>? samples,bool resetSamples=_F,List<int>? appendSamples,List<int>? removeSamples,})=>SchemaModel(id: deltaId!=null?(id??_H.id)+deltaId:resetId?1:(id??_H.id),enabled: resetEnabled?true:(enabled??_H.enabled),samples: ((resetSamples?const <int>[1, 2]:(samples??_H.samples)) as List<int>).$u(appendSamples,removeSamples),);
  static SchemaModel get newInstance=>SchemaModel();
  static Map<String,dynamic> get schema=>{'type':'object','properties':{'identifier':{'type':'integer',},'enabled':{'type':'boolean','description':'Enabled flag',},'samples':{'type':'array','items':{'type':'integer',},},},'required':[],'additionalProperties':_F};
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == Person ||v == Animal ||v == Dog ||v == Zoo ||v == ListenerModel ||v == FeatureModel ||v == ReflectModel ||v == NullableReflectSubObject ||v == NullableReflectCollectionsModel ||v == SchemaModel ;
Map<Type,$AClass> get $artifactMirror => {Person:$AClass<Person>($Person.$annotations,$Person.$fields,$Person.$methods,()=>$Person.newInstance,Object,[],[],$AT<Person>(),),ListenerModel:$AClass<ListenerModel>($ListenerModel.$annotations,$ListenerModel.$fields,$ListenerModel.$methods,()=>$ListenerModel.newInstance,Object,[],[],$AT<ListenerModel>(),),ReflectModel:$AClass<ReflectModel>($ReflectModel.$annotations,$ReflectModel.$fields,$ReflectModel.$methods,()=>$ReflectModel.newInstance,Object,[],[],$AT<ReflectModel>(),),NullableReflectSubObject:$AClass<NullableReflectSubObject>($NullableReflectSubObject.$annotations,$NullableReflectSubObject.$fields,$NullableReflectSubObject.$methods,()=>$NullableReflectSubObject.newInstance,Object,[],[],$AT<NullableReflectSubObject>(),),NullableReflectCollectionsModel:$AClass<NullableReflectCollectionsModel>($NullableReflectCollectionsModel.$annotations,$NullableReflectCollectionsModel.$fields,$NullableReflectCollectionsModel.$methods,()=>$NullableReflectCollectionsModel.newInstance,Object,[],[],$AT<NullableReflectCollectionsModel>(),),};
T $constructArtifact<T>() => T==Person ?$Person.newInstance as T :T==Animal ?$Animal.newInstance as T :T==Dog ?$Dog.newInstance as T :T==Zoo ?$Zoo.newInstance as T :T==ListenerModel ?$ListenerModel.newInstance as T :T==FeatureModel ?$FeatureModel.newInstance as T :T==ReflectModel ?$ReflectModel.newInstance as T :T==NullableReflectSubObject ?$NullableReflectSubObject.newInstance as T :T==NullableReflectCollectionsModel ?$NullableReflectCollectionsModel.newInstance as T :T==SchemaModel ?$SchemaModel.newInstance as T : throw Exception();
Map<String,dynamic> $artifactToMap(Object o)=>o is Person ?o.toMap():o is Animal ?o.toMap():o is Dog ?o.toMap():o is Zoo ?o.toMap():o is ListenerModel ?o.toMap():o is FeatureModel ?o.toMap():o is ReflectModel ?o.toMap():o is NullableReflectSubObject ?o.toMap():o is NullableReflectCollectionsModel ?o.toMap():o is SchemaModel ?o.toMap():throw Exception();
T $artifactFromMap<T>(Map<String,dynamic> m)=>T==Person ?$Person.fromMap(m) as T:T==Animal ?$Animal.fromMap(m) as T:T==Dog ?$Dog.fromMap(m) as T:T==Zoo ?$Zoo.fromMap(m) as T:T==ListenerModel ?$ListenerModel.fromMap(m) as T:T==FeatureModel ?$FeatureModel.fromMap(m) as T:T==ReflectModel ?$ReflectModel.fromMap(m) as T:T==NullableReflectSubObject ?$NullableReflectSubObject.fromMap(m) as T:T==NullableReflectCollectionsModel ?$NullableReflectCollectionsModel.fromMap(m) as T:T==SchemaModel ?$SchemaModel.fromMap(m) as T:throw Exception();
