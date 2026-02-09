// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:artifact_gen_fixture_basic/models.dart";import "dart:core";import "package:artifact/artifact.dart";

ArgumentError __x(String c,String f)=>ArgumentError('${'Missing required '}$c.$f');
const bool _T=true;const bool _F=false;int _ = ((){ArtifactCodecUtil.r(const [CompactCodec()]);if(!ArtifactAccessor.$i('artifact_gen_fixture_basic')){ArtifactAccessor.$r('artifact_gen_fixture_basic',ArtifactAccessor(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $FixtureBase on FixtureBase{
  FixtureBase get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;if (_H is FixtureChild){return (_H as FixtureChild).toMap();}return<String,dynamic>{'id':ArtifactCodecUtil.ea(id),}.$nn;}
  static ArtifactModelImporter<FixtureBase> get from=>ArtifactModelImporter<FixtureBase>(fromMap);
  static FixtureBase fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;if(m.$c('_subclass_FixtureBase')){String _I=m['_subclass_FixtureBase'] as String;if(_I=='FixtureChild'){return $FixtureChild.fromMap(m);}}return FixtureBase(id: m.$c('id') ?  ArtifactCodecUtil.da(m['id'], int) as int : 1,);}
  FixtureBase copyWith({int? id,bool resetId=_F,int? deltaId,}){if (_H is FixtureChild){return (_H as FixtureChild).copyWith(id: id,resetId:resetId,deltaId:deltaId,);}return FixtureBase(id: deltaId!=null?(id??_H.id)+deltaId:resetId?1:(id??_H.id),);}
  static FixtureBase get newInstance=>FixtureBase();
}
extension $FixtureChild on FixtureChild{
  FixtureChild get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'_subclass_FixtureBase': 'FixtureChild','id':ArtifactCodecUtil.ea(id),'name':ArtifactCodecUtil.ea(name),}.$nn;}
  static ArtifactModelImporter<FixtureChild> get from=>ArtifactModelImporter<FixtureChild>(fromMap);
  static FixtureChild fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return FixtureChild(id: m.$c('id') ?  ArtifactCodecUtil.da(m['id'], int) as int : 2,name: m.$c('name') ?  ArtifactCodecUtil.da(m['name'], String) as String : 'child',);}
  FixtureChild copyWith({int? id,bool resetId=_F,int? deltaId,String? name,bool resetName=_F,})=>FixtureChild(id: deltaId!=null?(id??_H.id)+deltaId:resetId?2:(id??_H.id),name: resetName?'child':(name??_H.name),);
  static FixtureChild get newInstance=>FixtureChild();
}
extension $FixtureZoo on FixtureZoo{
  FixtureZoo get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'items':items.$m((e)=> e.toMap()).$l,}.$nn;}
  static ArtifactModelImporter<FixtureZoo> get from=>ArtifactModelImporter<FixtureZoo>(fromMap);
  static FixtureZoo fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return FixtureZoo(items: m.$c('items') ?  (m['items'] as List).$m((e)=>$FixtureBase.fromMap((e) as Map<String, dynamic>)).$l : const <FixtureBase>[],);}
  FixtureZoo copyWith({List<FixtureBase>? items,bool resetItems=_F,List<FixtureBase>? appendItems,List<FixtureBase>? removeItems,})=>FixtureZoo(items: ((resetItems?const <FixtureBase>[]:(items??_H.items)) as List<FixtureBase>).$u(appendItems,removeItems),);
  static FixtureZoo get newInstance=>FixtureZoo();
}
extension $FixtureModel on FixtureModel{
  FixtureModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'v':ArtifactCodecUtil.ea(value),'label':ArtifactCodecUtil.ea(label),'compact':ArtifactCodecUtil.ea(compact),}.$nn;}
  static ArtifactModelImporter<FixtureModel> get from=>ArtifactModelImporter<FixtureModel>(fromMap);
  static FixtureModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return FixtureModel(value: m.$c('v') ?  ArtifactCodecUtil.da(m['v'], int) as int : 4,label: m.$c('label') ?  ArtifactCodecUtil.da(m['label'], String) as String : 'label',compact: m.$c('compact') ?  ArtifactCodecUtil.da(m['compact'], Compact) as Compact : const Compact(9),);}
  FixtureModel copyWith({int? value,bool resetValue=_F,int? deltaValue,String? label,bool resetLabel=_F,Compact? compact,bool resetCompact=_F,})=>FixtureModel(value: deltaValue!=null?(value??_H.value)+deltaValue:resetValue?4:(value??_H.value),label: resetLabel?'label':(label??_H.label),compact: resetCompact?const Compact(9):(compact??_H.compact),);
  static FixtureModel get newInstance=>FixtureModel();
}
extension $ReflectFixture on ReflectFixture{
  ReflectFixture get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'count':ArtifactCodecUtil.ea(count),}.$nn;}
  static ArtifactModelImporter<ReflectFixture> get from=>ArtifactModelImporter<ReflectFixture>(fromMap);
  static ReflectFixture fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return ReflectFixture(count: m.$c('count') ?  ArtifactCodecUtil.da(m['count'], int) as int : 1,);}
  ReflectFixture copyWith({int? count,bool resetCount=_F,int? deltaCount,})=>ReflectFixture(count: deltaCount!=null?(count??_H.count)+deltaCount:resetCount?1:(count??_H.count),);
  static ReflectFixture get newInstance=>ReflectFixture();
  ArtifactMirror get $mirror{_;return ArtifactCodecUtil.m(_H)!;}
  static List<Object> get $annotations {_;return[Artifact(generateSchema: _F,compression: _F,reflection: _T,),];}
  static List<$AFld> get $fields{_;return[$AFld<ReflectFixture, int>('count',(i)=>i.count,(i,v)=>i.copyWith(count:v),[],),];}
  static List<$AMth> get $methods {_;return[];}
}
extension $SchemaFixture on SchemaFixture{
  SchemaFixture get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'identifier':ArtifactCodecUtil.ea(id),'active':ArtifactCodecUtil.ea(active),}.$nn;}
  static ArtifactModelImporter<SchemaFixture> get from=>ArtifactModelImporter<SchemaFixture>(fromMap);
  static SchemaFixture fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return SchemaFixture(id: m.$c('identifier') ?  ArtifactCodecUtil.da(m['identifier'], int) as int : 1,active: m.$c('active') ?  ArtifactCodecUtil.da(m['active'], bool) as bool : true,);}
  SchemaFixture copyWith({int? id,bool resetId=_F,int? deltaId,bool? active,bool resetActive=_F,})=>SchemaFixture(id: deltaId!=null?(id??_H.id)+deltaId:resetId?1:(id??_H.id),active: resetActive?true:(active??_H.active),);
  static SchemaFixture get newInstance=>SchemaFixture();
  static Map<String,dynamic> get schema=>{'type':'object','properties':{'identifier':{'type':'integer',},'active':{'type':'boolean',},},'required':['identifier','active'],'additionalProperties':_F};
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == FixtureBase ||v == FixtureChild ||v == FixtureZoo ||v == FixtureModel ||v == ReflectFixture ||v == SchemaFixture ;
Map<Type,$AClass> get $artifactMirror => {ReflectFixture:$AClass<ReflectFixture>($ReflectFixture.$annotations,$ReflectFixture.$fields,$ReflectFixture.$methods,()=>$ReflectFixture.newInstance,Object,[],[],),};
T $constructArtifact<T>() => T==FixtureBase ?$FixtureBase.newInstance as T :T==FixtureChild ?$FixtureChild.newInstance as T :T==FixtureZoo ?$FixtureZoo.newInstance as T :T==FixtureModel ?$FixtureModel.newInstance as T :T==ReflectFixture ?$ReflectFixture.newInstance as T :T==SchemaFixture ?$SchemaFixture.newInstance as T : throw Exception();
Map<String,dynamic> $artifactToMap(Object o)=>o is FixtureBase ?o.toMap():o is FixtureChild ?o.toMap():o is FixtureZoo ?o.toMap():o is FixtureModel ?o.toMap():o is ReflectFixture ?o.toMap():o is SchemaFixture ?o.toMap():throw Exception();
T $artifactFromMap<T>(Map<String,dynamic> m)=>T==FixtureBase ?$FixtureBase.fromMap(m) as T:T==FixtureChild ?$FixtureChild.fromMap(m) as T:T==FixtureZoo ?$FixtureZoo.fromMap(m) as T:T==FixtureModel ?$FixtureModel.fromMap(m) as T:T==ReflectFixture ?$ReflectFixture.fromMap(m) as T:T==SchemaFixture ?$SchemaFixture.fromMap(m) as T:throw Exception();
