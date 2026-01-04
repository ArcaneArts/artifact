// GENERATED – do not modify by hand

// ignore_for_file: camel_case_types
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: unused_element
import "package:example/example.dart";import "package:example/test_models.dart";import "dart:core";import "package:artifact/artifact.dart";
typedef _0=ArtifactCodecUtil;typedef _1=Map<String,dynamic>;typedef _2=List<String>;typedef _3=String;typedef _4=dynamic;typedef _5=int;typedef _6=ArtifactModelExporter;typedef _7=ArgumentError;typedef _8=Exception;typedef _9=SomeModel;typedef _a=ParentThing;typedef _b=SimpleModel;typedef _c=ModelWithDefaults;typedef _d=ModelWithNullable;typedef _e=ModelWithRename;typedef _f=ModelWithEnum;typedef _g=ModelWithList;typedef _h=ModelWithSet;typedef _i=ModelWithMap;typedef _j=Animal;typedef _k=Dog;typedef _l=Cat;typedef _m=Bird;typedef _n=Address;typedef _o=Person;typedef _p=Company;typedef _q=Zoo;typedef _r=Inventory;typedef _s=Event;typedef _t=Schedule;typedef _u=AttachmentModel;typedef _v=ReflectionModel;typedef _w=UncompressedModel;typedef _x=Vehicle;typedef _y=Car;typedef _z=Motorcycle;typedef _10=Garage;typedef _11=EmptyModel;typedef _12=SingleFieldModel;typedef _13=AllPrimitivesModel;typedef _14=DeeplyNestedModel;typedef _15=ArtifactModelImporter<SomeModel>;typedef _16=bool;typedef _17=ArtifactModelImporter<ParentThing>;typedef _18=List;typedef _19=List<SomeModel>;typedef _1a=ArtifactModelImporter<SimpleModel>;typedef _1b=ArtifactModelImporter<ModelWithDefaults>;typedef _1c=double;typedef _1d=ArtifactModelImporter<ModelWithNullable>;typedef _1e=ArtifactModelImporter<ModelWithRename>;typedef _1f=ArtifactModelImporter<ModelWithEnum>;typedef _1g=Status;typedef _1h=Priority;typedef _1i=ArtifactModelImporter<ModelWithList>;typedef _1j=List<int>;typedef _1k=List<double>;typedef _1l=ArtifactModelImporter<ModelWithSet>;typedef _1m=Set;typedef _1n=Set<String>;typedef _1o=Set<int>;typedef _1p=MapEntry;typedef _1q=MapEntry<String, int>;typedef _1r=MapEntry<String, String>;typedef _1s=ArtifactModelImporter<ModelWithMap>;typedef _1t=Map<String, int>;typedef _1u=Map<String, String>;typedef _1v=ArtifactModelImporter<Animal>;typedef _1w=ArtifactModelImporter<Dog>;typedef _1x=ArtifactModelImporter<Cat>;typedef _1y=ArtifactModelImporter<Bird>;typedef _1z=ArtifactModelImporter<Address>;typedef _20=ArtifactModelImporter<Person>;typedef _21=ArtifactModelImporter<Company>;typedef _22=List<Person>;typedef _23=MapEntry<String, List<String>>;typedef _24=ArtifactModelImporter<Zoo>;typedef _25=List<Animal>;typedef _26=Map<String, List<String>>;typedef _27=MapEntry<String, dynamic>;typedef _28=ArtifactModelImporter<Inventory>;typedef _29=Map<String, dynamic>;typedef _2a=List<Map<String, dynamic>>;typedef _2b=ArtifactModelImporter<Event>;typedef _2c=DateTime;typedef _2d=Duration;typedef _2e=ArtifactModelImporter<Schedule>;typedef _2f=List<Event>;typedef _2g=ArtifactModelImporter<AttachmentModel>;typedef _2h=ArtifactModelImporter<ReflectionModel>;typedef _2i=List<Object>;typedef _2j=Artifact;typedef _2k=CustomAnnotation;typedef _2l=List<$AFld>;typedef _2m=List<$AMth>;typedef _2n=MethodParameters;typedef _2o=ArtifactModelImporter<UncompressedModel>;typedef _2p=ArtifactModelImporter<Vehicle>;typedef _2q=ArtifactModelImporter<Car>;typedef _2r=ArtifactModelImporter<Motorcycle>;typedef _2s=ArtifactModelImporter<Garage>;typedef _2t=List<Vehicle>;typedef _2u=ArtifactModelImporter<EmptyModel>;typedef _2v=ArtifactModelImporter<SingleFieldModel>;typedef _2w=ArtifactModelImporter<AllPrimitivesModel>;typedef _2x=ArtifactModelImporter<DeeplyNestedModel>;typedef _2y=ArtifactAccessor;typedef _2z=$AClass;typedef _30=Object;typedef _31=$AClass<ReflectionModel>;typedef _32=List<dynamic>;
_7 __x(_3 c,_3 f)=>_7('${_S[85]}$c.$f');
const _2 _S=['name','address','SomeModel','models','SimpleModel','count','ratio','active','optionalName','optionalAge','optionalRatio','desc','ModelWithRename','status','priority','ModelWithEnum','tags','numbers','values','uniqueTags','uniqueNumbers','scores','metadata','health','_subclass_Animal','Bird','Animal','breed','goodBoy','lives','indoor','wingspan','canFly','street','city','zipCode','country','Address','firstName','lastName','Person','headquarters','employees','Company','animals','exhibits','stock','categories','transactions','title','startTime','endTime','duration','Event','events','createdAt','description','content','internalId','AttachmentModel','value','ReflectionModel','greet','multiply','brand','year','_subclass_Vehicle','Motorcycle','Vehicle','doors','fuelType','type','engineCC','vehicles','featuredVehicle','Garage','SingleFieldModel','stringVal','intVal','doubleVal','boolVal','AllPrimitivesModel','child','DeeplyNestedModel','example','Missing required '];const _32 _V=[<_9>[],'default',true,<_3>[],<_5>[],<_1c>[],<_3>{},<_5>{},<_3,_5>{},<_3,_3>{},<_o>[],<_j>[],<_3,_2>{},<_29>[],<_s>[],<_x>[]];const _16 _T=true;const _16 _F=false;_5 _ = ((){if(!_2y.$i(_S[84])){_2y.$r(_S[84],_2y(isArtifact: $isArtifact,artifactMirror:$artifactMirror,constructArtifact:$constructArtifact,artifactToMap:$artifactToMap,artifactFromMap:$artifactFromMap));}return 0;})();

extension $SomeModel on _9{
  _9 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{'age':_0.ea(age),_S[0]:_0.ea(name),'ssn':_0.ea(ssn),_S[1]:_0.ea(address),}.$nn;}
  static _15 get from=>_15(fromMap);
  static _9 fromMap(_1 r){_;_1 m=r.$nn;return _9(age: m.$c('age')? _0.da(m['age'], _5) as _5:throw __x(_S[2],'age'),name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[2],_S[0]),ssn: m.$c('ssn')? _0.da(m['ssn'], _3) as _3:throw __x(_S[2],'ssn'),address: m.$c(_S[1])? _0.da(m[_S[1]], _3) as _3:throw __x(_S[2],_S[1]),);}
  _9 copyWith({_5? age,_5? deltaAge,_3? name,_3? ssn,_3? address,})=>_9(age: deltaAge!=null?(age??_H.age)+deltaAge:age??_H.age,name: name??_H.name,ssn: ssn??_H.ssn,address: address??_H.address,);
  static _9 get newInstance=>_9(age: 0,name: '',ssn: '',address: '',);
}
extension $ParentThing on _a{
  _a get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[3]:models.$m((e)=> e.toMap()).$l,}.$nn;}
  static _17 get from=>_17(fromMap);
  static _a fromMap(_1 r){_;_1 m=r.$nn;return _a(models: m.$c(_S[3]) ?  (m[_S[3]] as _18).$m((e)=>$SomeModel.fromMap((e) as Map<String, dynamic>)).$l : _V[0],);}
  _a copyWith({_19? models,_16 resetModels=_F,_19? appendModels,_19? removeModels,})=>_a(models: ((resetModels?_V[0]:(models??_H.models)) as _19).$u(appendModels,removeModels),);
  static _a get newInstance=>_a();
}
extension $SimpleModel on _b{
  _b get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),'age':_0.ea(age),}.$nn;}
  static _1a get from=>_1a(fromMap);
  static _b fromMap(_1 r){_;_1 m=r.$nn;return _b(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[4],_S[0]),age: m.$c('age')? _0.da(m['age'], _5) as _5:throw __x(_S[4],'age'),);}
  _b copyWith({_3? name,_5? age,_5? deltaAge,})=>_b(name: name??_H.name,age: deltaAge!=null?(age??_H.age)+deltaAge:age??_H.age,);
  static _b get newInstance=>_b(name: '',age: 0,);
}
extension $ModelWithDefaults on _c{
  _c get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[5]:_0.ea(count),_S[6]:_0.ea(ratio),_S[7]:_0.ea(active),}.$nn;}
  static _1b get from=>_1b(fromMap);
  static _c fromMap(_1 r){_;_1 m=r.$nn;return _c(name: m.$c(_S[0]) ?  _0.da(m[_S[0]], _3) as _3 : _V[1],count: m.$c(_S[5]) ?  _0.da(m[_S[5]], _5) as _5 : 0,ratio: m.$c(_S[6]) ?  _0.da(m[_S[6]], _1c) as _1c : 1.0,active: m.$c(_S[7]) ?  _0.da(m[_S[7]], _16) as _16 : _V[2],);}
  _c copyWith({_3? name,_16 resetName=_F,_5? count,_16 resetCount=_F,_5? deltaCount,_1c? ratio,_16 resetRatio=_F,_1c? deltaRatio,_16? active,_16 resetActive=_F,})=>_c(name: resetName?_V[1]:(name??_H.name),count: deltaCount!=null?(count??_H.count)+deltaCount:resetCount?0:(count??_H.count),ratio: deltaRatio!=null?(ratio??_H.ratio)+deltaRatio:resetRatio?1.0:(ratio??_H.ratio),active: resetActive?_V[2]:(active??_H.active),);
  static _c get newInstance=>_c();
}
extension $ModelWithNullable on _d{
  _d get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[8]:_0.ea(optionalName),_S[9]:_0.ea(optionalAge),_S[10]:_0.ea(optionalRatio),}.$nn;}
  static _1d get from=>_1d(fromMap);
  static _d fromMap(_1 r){_;_1 m=r.$nn;return _d(optionalName: m.$c(_S[8]) ?  _0.da(m[_S[8]], _3) as _3? : null,optionalAge: m.$c(_S[9]) ?  _0.da(m[_S[9]], _5) as _5? : null,optionalRatio: m.$c(_S[10]) ?  _0.da(m[_S[10]], _1c) as _1c? : null,);}
  _d copyWith({_3? optionalName,_16 deleteOptionalName=_F,_5? optionalAge,_16 deleteOptionalAge=_F,_5? deltaOptionalAge,_1c? optionalRatio,_16 deleteOptionalRatio=_F,_1c? deltaOptionalRatio,})=>_d(optionalName: deleteOptionalName?null:(optionalName??_H.optionalName),optionalAge: deltaOptionalAge!=null?(optionalAge??_H.optionalAge??0)+deltaOptionalAge:deleteOptionalAge?null:(optionalAge??_H.optionalAge),optionalRatio: deltaOptionalRatio!=null?(optionalRatio??_H.optionalRatio??0)+deltaOptionalRatio:deleteOptionalRatio?null:(optionalRatio??_H.optionalRatio),);
  static _d get newInstance=>_d();
}
extension $ModelWithRename on _e{
  _e get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{'n':_0.ea(name),'a':_0.ea(age),_S[11]:_0.ea(description),}.$nn;}
  static _1e get from=>_1e(fromMap);
  static _e fromMap(_1 r){_;_1 m=r.$nn;return _e(name: m.$c('n')? _0.da(m['n'], _3) as _3:throw __x(_S[12],_S[0]),age: m.$c('a')? _0.da(m['a'], _5) as _5:throw __x(_S[12],'age'),description: m.$c(_S[11]) ?  _0.da(m[_S[11]], _3) as _3? : null,);}
  _e copyWith({_3? name,_5? age,_5? deltaAge,_3? description,_16 deleteDescription=_F,})=>_e(name: name??_H.name,age: deltaAge!=null?(age??_H.age)+deltaAge:age??_H.age,description: deleteDescription?null:(description??_H.description),);
  static _e get newInstance=>_e(name: '',age: 0,);
}
extension $ModelWithEnum on _f{
  _f get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[13]:status.name,_S[14]:priority?.name,}.$nn;}
  static _1f get from=>_1f(fromMap);
  static _f fromMap(_1 r){_;_1 m=r.$nn;return _f(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[15],_S[0]),status: m.$c(_S[13])?_0.e(Status.values, m[_S[13]]) as Status:throw __x(_S[15],_S[13]),priority: m.$c(_S[14]) ? _0.e(Priority.values, m[_S[14]]) as Priority? : null,);}
  _f copyWith({_3? name,_1g? status,_1h? priority,_16 deletePriority=_F,})=>_f(name: name??_H.name,status: status??_H.status,priority: deletePriority?null:(priority??_H.priority),);
  static _f get newInstance=>_f(name: '',status: _1g.values.first,);
}
extension $ModelWithList on _g{
  _g get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[16]:tags.$m((e)=> _0.ea(e)).$l,_S[17]:numbers.$m((e)=> _0.ea(e)).$l,_S[18]:values.$m((e)=> _0.ea(e)).$l,}.$nn;}
  static _1i get from=>_1i(fromMap);
  static _g fromMap(_1 r){_;_1 m=r.$nn;return _g(tags: m.$c(_S[16]) ?  (m[_S[16]] as _18).$m((e)=> _0.da(e, _3) as _3).$l : _V[3],numbers: m.$c(_S[17]) ?  (m[_S[17]] as _18).$m((e)=> _0.da(e, _5) as _5).$l : _V[4],values: m.$c(_S[18]) ?  (m[_S[18]] as _18).$m((e)=> _0.da(e, _1c) as _1c).$l : _V[5],);}
  _g copyWith({_2? tags,_16 resetTags=_F,_2? appendTags,_2? removeTags,_1j? numbers,_16 resetNumbers=_F,_1j? appendNumbers,_1j? removeNumbers,_1k? values,_16 resetValues=_F,_1k? appendValues,_1k? removeValues,})=>_g(tags: ((resetTags?_V[3]:(tags??_H.tags)) as _2).$u(appendTags,removeTags),numbers: ((resetNumbers?_V[4]:(numbers??_H.numbers)) as _1j).$u(appendNumbers,removeNumbers),values: ((resetValues?_V[5]:(values??_H.values)) as _1k).$u(appendValues,removeValues),);
  static _g get newInstance=>_g();
}
extension $ModelWithSet on _h{
  _h get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[19]:uniqueTags.$m((e)=> _0.ea(e)).$l,_S[20]:uniqueNumbers.$m((e)=> _0.ea(e)).$l,}.$nn;}
  static _1l get from=>_1l(fromMap);
  static _h fromMap(_1 r){_;_1 m=r.$nn;return _h(uniqueTags: m.$c(_S[19]) ?  (m[_S[19]] as _18).$m((e)=> _0.da(e, _3) as _3).$s : _V[6],uniqueNumbers: m.$c(_S[20]) ?  (m[_S[20]] as _18).$m((e)=> _0.da(e, _5) as _5).$s : _V[7],);}
  _h copyWith({_1n? uniqueTags,_16 resetUniqueTags=_F,_1n? appendUniqueTags,_1n? removeUniqueTags,_1o? uniqueNumbers,_16 resetUniqueNumbers=_F,_1o? appendUniqueNumbers,_1o? removeUniqueNumbers,})=>_h(uniqueTags: ((resetUniqueTags?_V[6]:(uniqueTags??_H.uniqueTags)) as _1n).$u(appendUniqueTags,removeUniqueTags),uniqueNumbers: ((resetUniqueNumbers?_V[7]:(uniqueNumbers??_H.uniqueNumbers)) as _1o).$u(appendUniqueNumbers,removeUniqueNumbers),);
  static _h get newInstance=>_h();
}
extension $ModelWithMap on _i{
  _i get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[21]:scores.$m((k,v)=>_1p(k, _0.ea(v))),_S[22]:metadata.$m((k,v)=>_1p(k, _0.ea(v))),}.$nn;}
  static _1s get from=>_1s(fromMap);
  static _i fromMap(_1 r){_;_1 m=r.$nn;return _i(scores: m.$c(_S[21]) ?  _0.fe((m[_S[21]] as Map).$e.$m((e)=>_1q(e.key, _0.da(e.value, _5) as _5))) : _V[8],metadata: m.$c(_S[22]) ?  _0.fe((m[_S[22]] as Map).$e.$m((e)=>_1r(e.key, _0.da(e.value, _3) as _3))) : _V[9],);}
  _i copyWith({_1t? scores,_16 resetScores=_F,_1u? metadata,_16 resetMetadata=_F,})=>_i(scores: resetScores?_V[8]:(scores??_H.scores),metadata: resetMetadata?_V[9]:(metadata??_H.metadata),);
  static _i get newInstance=>_i();
}
extension $Animal on _j{
  _j get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;if (_H is _k){return (_H as _k).toMap();}if (_H is _l){return (_H as _l).toMap();}if (_H is _m){return (_H as _m).toMap();}return<_3,_4>{_S[0]:_0.ea(name),_S[23]:_0.ea(health),}.$nn;}
  static _1v get from=>_1v(fromMap);
  static _j fromMap(_1 r){_;_1 m=r.$nn;if(m.$c(_S[24])){String _I=m[_S[24]] as _3;if(_I=='Dog'){return $Dog.fromMap(m);}if(_I=='Cat'){return $Cat.fromMap(m);}if(_I==_S[25]){return $Bird.fromMap(m);}}return _j(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[26],_S[0]),health: m.$c(_S[23]) ?  _0.da(m[_S[23]], _5) as _5 : 100,);}
  _j copyWith({_3? name,_5? health,_16 resetHealth=_F,_5? deltaHealth,}){if (_H is _k){return (_H as _k).copyWith(name: name,health: health,resetHealth:resetHealth,deltaHealth:deltaHealth,);}if (_H is _l){return (_H as _l).copyWith(name: name,health: health,resetHealth:resetHealth,deltaHealth:deltaHealth,);}if (_H is _m){return (_H as _m).copyWith(name: name,health: health,resetHealth:resetHealth,deltaHealth:deltaHealth,);}return _j(name: name??_H.name,health: deltaHealth!=null?(health??_H.health)+deltaHealth:resetHealth?100:(health??_H.health),);}
  static _j get newInstance=>_j(name: '',);
}
extension $Dog on _k{
  _k get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[24]: 'Dog',_S[0]:_0.ea(name),_S[23]:_0.ea(health),_S[27]:_0.ea(breed),_S[28]:_0.ea(goodBoy),}.$nn;}
  static _1w get from=>_1w(fromMap);
  static _k fromMap(_1 r){_;_1 m=r.$nn;return _k(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x('Dog',_S[0]),health: m.$c(_S[23]) ?  _0.da(m[_S[23]], _5) as _5 : 100,breed: m.$c(_S[27])? _0.da(m[_S[27]], _3) as _3:throw __x('Dog',_S[27]),goodBoy: m.$c(_S[28]) ?  _0.da(m[_S[28]], _16) as _16 : _V[2],);}
  _k copyWith({_3? name,_5? health,_16 resetHealth=_F,_5? deltaHealth,_3? breed,_16? goodBoy,_16 resetGoodBoy=_F,})=>_k(name: name??_H.name,health: deltaHealth!=null?(health??_H.health)+deltaHealth:resetHealth?100:(health??_H.health),breed: breed??_H.breed,goodBoy: resetGoodBoy?_V[2]:(goodBoy??_H.goodBoy),);
  static _k get newInstance=>_k(name: '',breed: '',);
}
extension $Cat on _l{
  _l get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[24]: 'Cat',_S[0]:_0.ea(name),_S[23]:_0.ea(health),_S[29]:_0.ea(lives),_S[30]:_0.ea(indoor),}.$nn;}
  static _1x get from=>_1x(fromMap);
  static _l fromMap(_1 r){_;_1 m=r.$nn;return _l(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x('Cat',_S[0]),health: m.$c(_S[23]) ?  _0.da(m[_S[23]], _5) as _5 : 100,lives: m.$c(_S[29]) ?  _0.da(m[_S[29]], _5) as _5 : 9,indoor: m.$c(_S[30]) ?  _0.da(m[_S[30]], _16) as _16 : _V[2],);}
  _l copyWith({_3? name,_5? health,_16 resetHealth=_F,_5? deltaHealth,_5? lives,_16 resetLives=_F,_5? deltaLives,_16? indoor,_16 resetIndoor=_F,})=>_l(name: name??_H.name,health: deltaHealth!=null?(health??_H.health)+deltaHealth:resetHealth?100:(health??_H.health),lives: deltaLives!=null?(lives??_H.lives)+deltaLives:resetLives?9:(lives??_H.lives),indoor: resetIndoor?_V[2]:(indoor??_H.indoor),);
  static _l get newInstance=>_l(name: '',);
}
extension $Bird on _m{
  _m get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[24]: 'Bird',_S[0]:_0.ea(name),_S[23]:_0.ea(health),_S[31]:_0.ea(wingspan),_S[32]:_0.ea(canFly),}.$nn;}
  static _1y get from=>_1y(fromMap);
  static _m fromMap(_1 r){_;_1 m=r.$nn;return _m(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[25],_S[0]),health: m.$c(_S[23]) ?  _0.da(m[_S[23]], _5) as _5 : 100,wingspan: m.$c(_S[31])? _0.da(m[_S[31]], _1c) as _1c:throw __x(_S[25],_S[31]),canFly: m.$c(_S[32]) ?  _0.da(m[_S[32]], _16) as _16 : _V[2],);}
  _m copyWith({_3? name,_5? health,_16 resetHealth=_F,_5? deltaHealth,_1c? wingspan,_1c? deltaWingspan,_16? canFly,_16 resetCanFly=_F,})=>_m(name: name??_H.name,health: deltaHealth!=null?(health??_H.health)+deltaHealth:resetHealth?100:(health??_H.health),wingspan: deltaWingspan!=null?(wingspan??_H.wingspan)+deltaWingspan:wingspan??_H.wingspan,canFly: resetCanFly?_V[2]:(canFly??_H.canFly),);
  static _m get newInstance=>_m(name: '',wingspan: 0,);
}
extension $Address on _n{
  _n get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[33]:_0.ea(street),_S[34]:_0.ea(city),_S[35]:_0.ea(zipCode),_S[36]:_0.ea(country),}.$nn;}
  static _1z get from=>_1z(fromMap);
  static _n fromMap(_1 r){_;_1 m=r.$nn;return _n(street: m.$c(_S[33])? _0.da(m[_S[33]], _3) as _3:throw __x(_S[37],_S[33]),city: m.$c(_S[34])? _0.da(m[_S[34]], _3) as _3:throw __x(_S[37],_S[34]),zipCode: m.$c(_S[35])? _0.da(m[_S[35]], _3) as _3:throw __x(_S[37],_S[35]),country: m.$c(_S[36]) ?  _0.da(m[_S[36]], _3) as _3? : null,);}
  _n copyWith({_3? street,_3? city,_3? zipCode,_3? country,_16 deleteCountry=_F,})=>_n(street: street??_H.street,city: city??_H.city,zipCode: zipCode??_H.zipCode,country: deleteCountry?null:(country??_H.country),);
  static _n get newInstance=>_n(street: '',city: '',zipCode: '',);
}
extension $Person on _o{
  _o get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[38]:_0.ea(firstName),_S[39]:_0.ea(lastName),'age':_0.ea(age),_S[1]:address.toMap(),}.$nn;}
  static _20 get from=>_20(fromMap);
  static _o fromMap(_1 r){_;_1 m=r.$nn;return _o(firstName: m.$c(_S[38])? _0.da(m[_S[38]], _3) as _3:throw __x(_S[40],_S[38]),lastName: m.$c(_S[39])? _0.da(m[_S[39]], _3) as _3:throw __x(_S[40],_S[39]),age: m.$c('age')? _0.da(m['age'], _5) as _5:throw __x(_S[40],'age'),address: m.$c(_S[1])?$Address.fromMap((m[_S[1]]) as Map<String, dynamic>):throw __x(_S[40],_S[1]),);}
  _o copyWith({_3? firstName,_3? lastName,_5? age,_5? deltaAge,_n? address,})=>_o(firstName: firstName??_H.firstName,lastName: lastName??_H.lastName,age: deltaAge!=null?(age??_H.age)+deltaAge:age??_H.age,address: address??_H.address,);
  static _o get newInstance=>_o(firstName: '',lastName: '',age: 0,address: $Address.newInstance,);
}
extension $Company on _p{
  _p get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[41]:headquarters.toMap(),_S[42]:employees.$m((e)=> e.toMap()).$l,}.$nn;}
  static _21 get from=>_21(fromMap);
  static _p fromMap(_1 r){_;_1 m=r.$nn;return _p(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[43],_S[0]),headquarters: m.$c(_S[41])?$Address.fromMap((m[_S[41]]) as Map<String, dynamic>):throw __x(_S[43],_S[41]),employees: m.$c(_S[42]) ?  (m[_S[42]] as _18).$m((e)=>$Person.fromMap((e) as Map<String, dynamic>)).$l : _V[10],);}
  _p copyWith({_3? name,_n? headquarters,_22? employees,_16 resetEmployees=_F,_22? appendEmployees,_22? removeEmployees,})=>_p(name: name??_H.name,headquarters: headquarters??_H.headquarters,employees: ((resetEmployees?_V[10]:(employees??_H.employees)) as _22).$u(appendEmployees,removeEmployees),);
  static _p get newInstance=>_p(name: '',headquarters: $Address.newInstance,);
}
extension $Zoo on _q{
  _q get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[44]:animals.$m((e)=> e.toMap()).$l,_S[45]:exhibits.$m((k,v)=>_1p(k, v.$m((e)=> _0.ea(e)).$l)),}.$nn;}
  static _24 get from=>_24(fromMap);
  static _q fromMap(_1 r){_;_1 m=r.$nn;return _q(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x('Zoo',_S[0]),animals: m.$c(_S[44]) ?  (m[_S[44]] as _18).$m((e)=>$Animal.fromMap((e) as Map<String, dynamic>)).$l : _V[11],exhibits: m.$c(_S[45]) ?  _0.fe((m[_S[45]] as Map).$e.$m((e)=>_23(e.key, (e.value as _18).$m((e)=> _0.da(e, _3) as _3).$l))) : _V[12],);}
  _q copyWith({_3? name,_25? animals,_16 resetAnimals=_F,_25? appendAnimals,_25? removeAnimals,_26? exhibits,_16 resetExhibits=_F,})=>_q(name: name??_H.name,animals: ((resetAnimals?_V[11]:(animals??_H.animals)) as _25).$u(appendAnimals,removeAnimals),exhibits: resetExhibits?_V[12]:(exhibits??_H.exhibits),);
  static _q get newInstance=>_q(name: '',);
}
extension $Inventory on _r{
  _r get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[46]:stock.$m((k,v)=>_1p(k, _0.ea(v))),_S[47]:categories.$m((e)=> _0.ea(e)).$l,_S[48]:transactions.$m((e)=> e.$m((k,v)=>_1p(k,v))).$l,}.$nn;}
  static _28 get from=>_28(fromMap);
  static _r fromMap(_1 r){_;_1 m=r.$nn;return _r(stock: m.$c(_S[46]) ?  _0.fe((m[_S[46]] as Map).$e.$m((e)=>_1q(e.key, _0.da(e.value, _5) as _5))) : _V[8],categories: m.$c(_S[47]) ?  (m[_S[47]] as _18).$m((e)=> _0.da(e, _3) as _3).$s : _V[6],transactions: m.$c(_S[48]) ?  (m[_S[48]] as _18).$m((e)=> _0.fe((e as Map).$e.$m((e)=>_27(e.key,e.value)))).$l : _V[13],);}
  _r copyWith({_1t? stock,_16 resetStock=_F,_1n? categories,_16 resetCategories=_F,_1n? appendCategories,_1n? removeCategories,_2a? transactions,_16 resetTransactions=_F,_2a? appendTransactions,_2a? removeTransactions,})=>_r(stock: resetStock?_V[8]:(stock??_H.stock),categories: ((resetCategories?_V[6]:(categories??_H.categories)) as _1n).$u(appendCategories,removeCategories),transactions: ((resetTransactions?_V[13]:(transactions??_H.transactions)) as _2a).$u(appendTransactions,removeTransactions),);
  static _r get newInstance=>_r();
}
extension $Event on _s{
  _s get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[49]:_0.ea(title),_S[50]:_0.ea(startTime),_S[51]:_0.ea(endTime),_S[52]:_0.ea(duration),}.$nn;}
  static _2b get from=>_2b(fromMap);
  static _s fromMap(_1 r){_;_1 m=r.$nn;return _s(title: m.$c(_S[49])? _0.da(m[_S[49]], _3) as _3:throw __x(_S[53],_S[49]),startTime: m.$c(_S[50]) ?  _0.da(m[_S[50]], _2c) as _2c? : null,endTime: m.$c(_S[51]) ?  _0.da(m[_S[51]], _2c) as _2c? : null,duration: m.$c(_S[52]) ?  _0.da(m[_S[52]], _2d) as _2d? : null,);}
  _s copyWith({_3? title,_2c? startTime,_16 deleteStartTime=_F,_2c? endTime,_16 deleteEndTime=_F,_2d? duration,_16 deleteDuration=_F,})=>_s(title: title??_H.title,startTime: deleteStartTime?null:(startTime??_H.startTime),endTime: deleteEndTime?null:(endTime??_H.endTime),duration: deleteDuration?null:(duration??_H.duration),);
  static _s get newInstance=>_s(title: '',);
}
extension $Schedule on _t{
  _t get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[54]:events.$m((e)=> e.toMap()).$l,_S[55]:_0.ea(createdAt),}.$nn;}
  static _2e get from=>_2e(fromMap);
  static _t fromMap(_1 r){_;_1 m=r.$nn;return _t(events: m.$c(_S[54]) ?  (m[_S[54]] as _18).$m((e)=>$Event.fromMap((e) as _29)).$l : _V[14],createdAt: m.$c(_S[55]) ?  _0.da(m[_S[55]], _2c) as _2c? : null,);}
  _t copyWith({_2f? events,_16 resetEvents=_F,_2f? appendEvents,_2f? removeEvents,_2c? createdAt,_16 deleteCreatedAt=_F,})=>_t(events: ((resetEvents?_V[14]:(events??_H.events)) as _2f).$u(appendEvents,removeEvents),createdAt: deleteCreatedAt?null:(createdAt??_H.createdAt),);
  static _t get newInstance=>_t();
}
extension $AttachmentModel on _u{
  _u get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[56]:_0.ea(description),_S[57]:_0.ea(content),_S[58]:_0.ea(internalId),}.$nn;}
  static _2g get from=>_2g(fromMap);
  static _u fromMap(_1 r){_;_1 m=r.$nn;return _u(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[59],_S[0]),description: m.$c(_S[56])? _0.da(m[_S[56]], _3) as _3:throw __x(_S[59],_S[56]),content: m.$c(_S[57])? _0.da(m[_S[57]], _3) as _3:throw __x(_S[59],_S[57]),internalId: m.$c(_S[58])? _0.da(m[_S[58]], _3) as _3:throw __x(_S[59],_S[58]),);}
  _u copyWith({_3? name,_3? description,_3? content,_3? internalId,})=>_u(name: name??_H.name,description: description??_H.description,content: content??_H.content,internalId: internalId??_H.internalId,);
  static _u get newInstance=>_u(name: '',description: '',content: '',internalId: '',);
  Iterable<R> getAttachments<T, R>(T t) => _0.a<T,R>(t,[$At<UIType,_3>(UIType.title,name),$At<UIType,_3>(UIType.subtitle,description),$At<UIType,_3>(UIType.body,content),$At<UIType,_3>(UIType.hidden,internalId)]);
  R? getAttachment<T,R>(T t)=>getAttachments<T,R>(t).$f;
  static const List<dynamic> rootAttachments = [UIType.title];
}
extension $ReflectionModel on _v{
  _v get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[60]:_0.ea(value),}.$nn;}
  static _2h get from=>_2h(fromMap);
  static _v fromMap(_1 r){_;_1 m=r.$nn;return _v(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[61],_S[0]),value: m.$c(_S[60])? _0.da(m[_S[60]], _5) as _5:throw __x(_S[61],_S[60]),);}
  _v copyWith({_3? name,_5? value,_5? deltaValue,})=>_v(name: name??_H.name,value: deltaValue!=null?(value??_H.value)+deltaValue:value??_H.value,);
  static _v get newInstance=>_v(name: '',value: 0,);
  static _2i get $annotations {_;return[_2j(generateSchema: _F,compression: _T,reflection: _T,),_2k(),];}
  static _2l get $fields{_;return[$AFld<_v, _3>(_S[0],(i)=>i.name,(i,v)=>i.copyWith(name:v),[_2k(),],),$AFld<_v, _5>(_S[60],(i)=>i.value,(i,v)=>i.copyWith(value:v),[],),];}
  static _2m get $methods {_;return[$AMth<_v, _3>(_S[62],(i, p)=>i.greet(p.o<_3>(0),),[_3,],{},[_2k(),],),$AMth<_v, _5>(_S[63],(i, p)=>i.multiply(p.o<_5>(0),b: p.n<_5>('b'),),[_5,],{'b': _5,},[],),];}
}
extension $UncompressedModel on UncompressedModel{
  UncompressedModel get _H=>this;
  ArtifactModelExporter get to=>ArtifactModelExporter(toMap);
  Map<String,dynamic> toMap(){_;return<String,dynamic>{'name':ArtifactCodecUtil.ea(name),'value':ArtifactCodecUtil.ea(value),'items':items.$m((e)=> ArtifactCodecUtil.ea(e)).$l,}.$nn;}
  static ArtifactModelImporter<UncompressedModel> get from=>ArtifactModelImporter<UncompressedModel>(fromMap);
  static UncompressedModel fromMap(Map<String,dynamic> r){_;Map<String,dynamic> m=r.$nn;return UncompressedModel(name: m.$c('name')? ArtifactCodecUtil.da(m['name'], String) as String:throw __x('UncompressedModel','name'),value: m.$c('value')? ArtifactCodecUtil.da(m['value'], int) as int:throw __x('UncompressedModel','value'),items: m.$c('items') ?  (m['items'] as List).$m((e)=> ArtifactCodecUtil.da(e, String) as String).$l : const [],);}
  UncompressedModel copyWith({String? name,int? value,int? deltaValue,List<String>? items,bool resetItems=_F,List<String>? appendItems,List<String>? removeItems,})=>UncompressedModel(name: name??_H.name,value: deltaValue!=null?(value??_H.value)+deltaValue:value??_H.value,items: ((resetItems?const []:(items??_H.items)) as List<String>).$u(appendItems,removeItems),);
  static UncompressedModel get newInstance=>UncompressedModel(name: '',value: 0,);
}
extension $Vehicle on _x{
  _x get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;if (_H is _y){return (_H as _y).toMap();}if (_H is _z){return (_H as _z).toMap();}return<_3,_4>{_S[64]:_0.ea(brand),_S[65]:_0.ea(year),}.$nn;}
  static _2p get from=>_2p(fromMap);
  static _x fromMap(_1 r){_;_1 m=r.$nn;if(m.$c(_S[66])){String _I=m[_S[66]] as _3;if(_I=='Car'){return $Car.fromMap(m);}if(_I==_S[67]){return $Motorcycle.fromMap(m);}}return _x(brand: m.$c(_S[64])? _0.da(m[_S[64]], _3) as _3:throw __x(_S[68],_S[64]),year: m.$c(_S[65])? _0.da(m[_S[65]], _5) as _5:throw __x(_S[68],_S[65]),);}
  _x copyWith({_3? brand,_5? year,_5? deltaYear,}){if (_H is _y){return (_H as _y).copyWith(brand: brand,year: year,deltaYear:deltaYear,);}if (_H is _z){return (_H as _z).copyWith(brand: brand,year: year,deltaYear:deltaYear,);}return _x(brand: brand??_H.brand,year: deltaYear!=null?(year??_H.year)+deltaYear:year??_H.year,);}
  static _x get newInstance=>_x(brand: '',year: 0,);
}
extension $Car on _y{
  _y get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[66]: 'Car',_S[64]:_0.ea(brand),_S[65]:_0.ea(year),_S[69]:_0.ea(doors),_S[70]:_0.ea(fuelType),}.$nn;}
  static _2q get from=>_2q(fromMap);
  static _y fromMap(_1 r){_;_1 m=r.$nn;return _y(brand: m.$c(_S[64])? _0.da(m[_S[64]], _3) as _3:throw __x('Car',_S[64]),year: m.$c(_S[65])? _0.da(m[_S[65]], _5) as _5:throw __x('Car',_S[65]),doors: m.$c(_S[69])? _0.da(m[_S[69]], _5) as _5:throw __x('Car',_S[69]),fuelType: m.$c(_S[70])? _0.da(m[_S[70]], _3) as _3:throw __x('Car',_S[70]),);}
  _y copyWith({_3? brand,_5? year,_5? deltaYear,_5? doors,_5? deltaDoors,_3? fuelType,})=>_y(brand: brand??_H.brand,year: deltaYear!=null?(year??_H.year)+deltaYear:year??_H.year,doors: deltaDoors!=null?(doors??_H.doors)+deltaDoors:doors??_H.doors,fuelType: fuelType??_H.fuelType,);
  static _y get newInstance=>_y(brand: '',year: 0,doors: 0,fuelType: '',);
}
extension $Motorcycle on _z{
  _z get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[66]: 'Motorcycle',_S[64]:_0.ea(brand),_S[65]:_0.ea(year),_S[71]:_0.ea(type),_S[72]:_0.ea(engineCC),}.$nn;}
  static _2r get from=>_2r(fromMap);
  static _z fromMap(_1 r){_;_1 m=r.$nn;return _z(brand: m.$c(_S[64])? _0.da(m[_S[64]], _3) as _3:throw __x(_S[67],_S[64]),year: m.$c(_S[65])? _0.da(m[_S[65]], _5) as _5:throw __x(_S[67],_S[65]),type: m.$c(_S[71])? _0.da(m[_S[71]], _3) as _3:throw __x(_S[67],_S[71]),engineCC: m.$c(_S[72])? _0.da(m[_S[72]], _5) as _5:throw __x(_S[67],_S[72]),);}
  _z copyWith({_3? brand,_5? year,_5? deltaYear,_3? type,_5? engineCC,_5? deltaEngineCC,})=>_z(brand: brand??_H.brand,year: deltaYear!=null?(year??_H.year)+deltaYear:year??_H.year,type: type??_H.type,engineCC: deltaEngineCC!=null?(engineCC??_H.engineCC)+deltaEngineCC:engineCC??_H.engineCC,);
  static _z get newInstance=>_z(brand: '',year: 0,type: '',engineCC: 0,);
}
extension $Garage on _10{
  _10 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[73]:vehicles.$m((e)=> e.toMap()).$l,_S[74]:featuredVehicle?.toMap(),}.$nn;}
  static _2s get from=>_2s(fromMap);
  static _10 fromMap(_1 r){_;_1 m=r.$nn;return _10(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[75],_S[0]),vehicles: m.$c(_S[73]) ?  (m[_S[73]] as _18).$m((e)=>$Vehicle.fromMap((e) as _29)).$l : _V[15],featuredVehicle: m.$c(_S[74]) ? $Vehicle.fromMap((m[_S[74]]) as _29) : null,);}
  _10 copyWith({_3? name,_2t? vehicles,_16 resetVehicles=_F,_2t? appendVehicles,_2t? removeVehicles,_x? featuredVehicle,_16 deleteFeaturedVehicle=_F,})=>_10(name: name??_H.name,vehicles: ((resetVehicles?_V[15]:(vehicles??_H.vehicles)) as _2t).$u(appendVehicles,removeVehicles),featuredVehicle: deleteFeaturedVehicle?null:(featuredVehicle??_H.featuredVehicle),);
  static _10 get newInstance=>_10(name: '',);
}
extension $EmptyModel on _11{
  _11 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{}.$nn;}
  static _2u get from=>_2u(fromMap);
  static _11 fromMap(_1 r){_;_1 m=r.$nn;return _11();}
  static _11 get newInstance=>_11();
}
extension $SingleFieldModel on _12{
  _12 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[60]:_0.ea(value),}.$nn;}
  static _2v get from=>_2v(fromMap);
  static _12 fromMap(_1 r){_;_1 m=r.$nn;return _12(value: m.$c(_S[60])? _0.da(m[_S[60]], _3) as _3:throw __x(_S[76],_S[60]),);}
  _12 copyWith({_3? value,})=>_12(value: value??_H.value,);
  static _12 get newInstance=>_12(value: '',);
}
extension $AllPrimitivesModel on _13{
  _13 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[77]:_0.ea(stringVal),_S[78]:_0.ea(intVal),_S[79]:_0.ea(doubleVal),_S[80]:_0.ea(boolVal),}.$nn;}
  static _2w get from=>_2w(fromMap);
  static _13 fromMap(_1 r){_;_1 m=r.$nn;return _13(stringVal: m.$c(_S[77])? _0.da(m[_S[77]], _3) as _3:throw __x(_S[81],_S[77]),intVal: m.$c(_S[78])? _0.da(m[_S[78]], _5) as _5:throw __x(_S[81],_S[78]),doubleVal: m.$c(_S[79])? _0.da(m[_S[79]], _1c) as _1c:throw __x(_S[81],_S[79]),boolVal: m.$c(_S[80])? _0.da(m[_S[80]], _16) as _16:throw __x(_S[81],_S[80]),);}
  _13 copyWith({_3? stringVal,_5? intVal,_5? deltaIntVal,_1c? doubleVal,_1c? deltaDoubleVal,_16? boolVal,})=>_13(stringVal: stringVal??_H.stringVal,intVal: deltaIntVal!=null?(intVal??_H.intVal)+deltaIntVal:intVal??_H.intVal,doubleVal: deltaDoubleVal!=null?(doubleVal??_H.doubleVal)+deltaDoubleVal:doubleVal??_H.doubleVal,boolVal: boolVal??_H.boolVal,);
  static _13 get newInstance=>_13(stringVal: '',intVal: 0,doubleVal: 0,boolVal: _F,);
}
extension $DeeplyNestedModel on _14{
  _14 get _H=>this;
  _6 get to=>_6(toMap);
  _1 toMap(){_;return<_3,_4>{_S[0]:_0.ea(name),_S[82]:child?.toMap(),}.$nn;}
  static _2x get from=>_2x(fromMap);
  static _14 fromMap(_1 r){_;_1 m=r.$nn;return _14(name: m.$c(_S[0])? _0.da(m[_S[0]], _3) as _3:throw __x(_S[83],_S[0]),child: m.$c(_S[82]) ? $DeeplyNestedModel.fromMap((m[_S[82]]) as _29) : null,);}
  _14 copyWith({_3? name,_14? child,_16 deleteChild=_F,})=>_14(name: name??_H.name,child: deleteChild?null:(child??_H.child),);
  static _14 get newInstance=>_14(name: '',);
}

bool $isArtifact(dynamic v)=>v==null?false : v is! Type ?$isArtifact(v.runtimeType):v == _9 ||v == _a ||v == _b ||v == _c ||v == _d ||v == _e ||v == _f ||v == _g ||v == _h ||v == _i ||v == _j ||v == _k ||v == _l ||v == _m ||v == _n ||v == _o ||v == _p ||v == _q ||v == _r ||v == _s ||v == _t ||v == _u ||v == _v ||v == _w ||v == _x ||v == _y ||v == _z ||v == _10 ||v == _11 ||v == _12 ||v == _13 ||v == _14 ;
Map<Type,_2z> get $artifactMirror => {_v:$AClass<ReflectionModel>($ReflectionModel.$annotations,$ReflectionModel.$fields,$ReflectionModel.$methods,()=>$ReflectionModel.newInstance,_30,[],[],),};
T $constructArtifact<T>() => T==_9 ?$SomeModel.newInstance as T :T==_a ?$ParentThing.newInstance as T :T==_b ?$SimpleModel.newInstance as T :T==_c ?$ModelWithDefaults.newInstance as T :T==_d ?$ModelWithNullable.newInstance as T :T==_e ?$ModelWithRename.newInstance as T :T==_f ?$ModelWithEnum.newInstance as T :T==_g ?$ModelWithList.newInstance as T :T==_h ?$ModelWithSet.newInstance as T :T==_i ?$ModelWithMap.newInstance as T :T==_j ?$Animal.newInstance as T :T==_k ?$Dog.newInstance as T :T==_l ?$Cat.newInstance as T :T==_m ?$Bird.newInstance as T :T==_n ?$Address.newInstance as T :T==_o ?$Person.newInstance as T :T==_p ?$Company.newInstance as T :T==_q ?$Zoo.newInstance as T :T==_r ?$Inventory.newInstance as T :T==_s ?$Event.newInstance as T :T==_t ?$Schedule.newInstance as T :T==_u ?$AttachmentModel.newInstance as T :T==_v ?$ReflectionModel.newInstance as T :T==_w ?$UncompressedModel.newInstance as T :T==_x ?$Vehicle.newInstance as T :T==_y ?$Car.newInstance as T :T==_z ?$Motorcycle.newInstance as T :T==_10 ?$Garage.newInstance as T :T==_11 ?$EmptyModel.newInstance as T :T==_12 ?$SingleFieldModel.newInstance as T :T==_13 ?$AllPrimitivesModel.newInstance as T :T==_14 ?$DeeplyNestedModel.newInstance as T : throw _8();
_1 $artifactToMap(Object o)=>o is _9 ?o.toMap():o is _a ?o.toMap():o is _b ?o.toMap():o is _c ?o.toMap():o is _d ?o.toMap():o is _e ?o.toMap():o is _f ?o.toMap():o is _g ?o.toMap():o is _h ?o.toMap():o is _i ?o.toMap():o is _j ?o.toMap():o is _k ?o.toMap():o is _l ?o.toMap():o is _m ?o.toMap():o is _n ?o.toMap():o is _o ?o.toMap():o is _p ?o.toMap():o is _q ?o.toMap():o is _r ?o.toMap():o is _s ?o.toMap():o is _t ?o.toMap():o is _u ?o.toMap():o is _v ?o.toMap():o is _w ?o.toMap():o is _x ?o.toMap():o is _y ?o.toMap():o is _z ?o.toMap():o is _10 ?o.toMap():o is _11 ?o.toMap():o is _12 ?o.toMap():o is _13 ?o.toMap():o is _14 ?o.toMap():throw _8();
T $artifactFromMap<T>(_1 m)=>T==_9 ?$SomeModel.fromMap(m) as T:T==_a ?$ParentThing.fromMap(m) as T:T==_b ?$SimpleModel.fromMap(m) as T:T==_c ?$ModelWithDefaults.fromMap(m) as T:T==_d ?$ModelWithNullable.fromMap(m) as T:T==_e ?$ModelWithRename.fromMap(m) as T:T==_f ?$ModelWithEnum.fromMap(m) as T:T==_g ?$ModelWithList.fromMap(m) as T:T==_h ?$ModelWithSet.fromMap(m) as T:T==_i ?$ModelWithMap.fromMap(m) as T:T==_j ?$Animal.fromMap(m) as T:T==_k ?$Dog.fromMap(m) as T:T==_l ?$Cat.fromMap(m) as T:T==_m ?$Bird.fromMap(m) as T:T==_n ?$Address.fromMap(m) as T:T==_o ?$Person.fromMap(m) as T:T==_p ?$Company.fromMap(m) as T:T==_q ?$Zoo.fromMap(m) as T:T==_r ?$Inventory.fromMap(m) as T:T==_s ?$Event.fromMap(m) as T:T==_t ?$Schedule.fromMap(m) as T:T==_u ?$AttachmentModel.fromMap(m) as T:T==_v ?$ReflectionModel.fromMap(m) as T:T==_w ?$UncompressedModel.fromMap(m) as T:T==_x ?$Vehicle.fromMap(m) as T:T==_y ?$Car.fromMap(m) as T:T==_z ?$Motorcycle.fromMap(m) as T:T==_10 ?$Garage.fromMap(m) as T:T==_11 ?$EmptyModel.fromMap(m) as T:T==_12 ?$SingleFieldModel.fromMap(m) as T:T==_13 ?$AllPrimitivesModel.fromMap(m) as T:T==_14 ?$DeeplyNestedModel.fromMap(m) as T:throw _8();
