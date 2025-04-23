// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'all_fields.dart';

class AllFields2Mapper extends ClassMapperBase<AllFields2> {
  AllFields2Mapper._();

  static AllFields2Mapper? _instance;
  static AllFields2Mapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AllFields2Mapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AllFields2';

  static String _$aString(AllFields2 v) => v.aString;
  static const Field<AllFields2, String> _f$aString =
      Field('aString', _$aString, opt: true, def: "");
  static String? _$anString(AllFields2 v) => v.anString;
  static const Field<AllFields2, String> _f$anString =
      Field('anString', _$anString, opt: true);
  static String? _$anrString(AllFields2 v) => v.anrString;
  static const Field<AllFields2, String> _f$anrString =
      Field('anrString', _$anrString, opt: true, def: "");
  static int _$aInt(AllFields2 v) => v.aInt;
  static const Field<AllFields2, int> _f$aInt =
      Field('aInt', _$aInt, opt: true, def: 0);
  static double _$aDouble(AllFields2 v) => v.aDouble;
  static const Field<AllFields2, double> _f$aDouble =
      Field('aDouble', _$aDouble, opt: true, def: 0.0);
  static bool _$aBool(AllFields2 v) => v.aBool;
  static const Field<AllFields2, bool> _f$aBool =
      Field('aBool', _$aBool, opt: true, def: false);
  static DateTime _$aDateTime(AllFields2 v) => v.aDateTime;
  static const Field<AllFields2, DateTime> _f$aDateTime =
      Field('aDateTime', _$aDateTime);
  static Duration _$aDuration(AllFields2 v) => v.aDuration;
  static const Field<AllFields2, Duration> _f$aDuration =
      Field('aDuration', _$aDuration, opt: true, def: const Duration());

  @override
  final MappableFields<AllFields2> fields = const {
    #aString: _f$aString,
    #anString: _f$anString,
    #anrString: _f$anrString,
    #aInt: _f$aInt,
    #aDouble: _f$aDouble,
    #aBool: _f$aBool,
    #aDateTime: _f$aDateTime,
    #aDuration: _f$aDuration,
  };

  static AllFields2 _instantiate(DecodingData data) {
    return AllFields2(
        aString: data.dec(_f$aString),
        anString: data.dec(_f$anString),
        anrString: data.dec(_f$anrString),
        aInt: data.dec(_f$aInt),
        aDouble: data.dec(_f$aDouble),
        aBool: data.dec(_f$aBool),
        aDateTime: data.dec(_f$aDateTime),
        aDuration: data.dec(_f$aDuration));
  }

  @override
  final Function instantiate = _instantiate;

  static AllFields2 fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AllFields2>(map);
  }

  static AllFields2 fromJson(String json) {
    return ensureInitialized().decodeJson<AllFields2>(json);
  }
}

mixin AllFields2Mappable {
  String toJson() {
    return AllFields2Mapper.ensureInitialized()
        .encodeJson<AllFields2>(this as AllFields2);
  }

  Map<String, dynamic> toMap() {
    return AllFields2Mapper.ensureInitialized()
        .encodeMap<AllFields2>(this as AllFields2);
  }

  AllFields2CopyWith<AllFields2, AllFields2, AllFields2> get copyWith =>
      _AllFields2CopyWithImpl<AllFields2, AllFields2>(
          this as AllFields2, $identity, $identity);
  @override
  String toString() {
    return AllFields2Mapper.ensureInitialized()
        .stringifyValue(this as AllFields2);
  }

  @override
  bool operator ==(Object other) {
    return AllFields2Mapper.ensureInitialized()
        .equalsValue(this as AllFields2, other);
  }

  @override
  int get hashCode {
    return AllFields2Mapper.ensureInitialized().hashValue(this as AllFields2);
  }
}

extension AllFields2ValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AllFields2, $Out> {
  AllFields2CopyWith<$R, AllFields2, $Out> get $asAllFields2 =>
      $base.as((v, t, t2) => _AllFields2CopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AllFields2CopyWith<$R, $In extends AllFields2, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? aString,
      String? anString,
      String? anrString,
      int? aInt,
      double? aDouble,
      bool? aBool,
      DateTime? aDateTime,
      Duration? aDuration});
  AllFields2CopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AllFields2CopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AllFields2, $Out>
    implements AllFields2CopyWith<$R, AllFields2, $Out> {
  _AllFields2CopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AllFields2> $mapper =
      AllFields2Mapper.ensureInitialized();
  @override
  $R call(
          {String? aString,
          Object? anString = $none,
          Object? anrString = $none,
          int? aInt,
          double? aDouble,
          bool? aBool,
          DateTime? aDateTime,
          Duration? aDuration}) =>
      $apply(FieldCopyWithData({
        if (aString != null) #aString: aString,
        if (anString != $none) #anString: anString,
        if (anrString != $none) #anrString: anrString,
        if (aInt != null) #aInt: aInt,
        if (aDouble != null) #aDouble: aDouble,
        if (aBool != null) #aBool: aBool,
        if (aDateTime != null) #aDateTime: aDateTime,
        if (aDuration != null) #aDuration: aDuration
      }));
  @override
  AllFields2 $make(CopyWithData data) => AllFields2(
      aString: data.get(#aString, or: $value.aString),
      anString: data.get(#anString, or: $value.anString),
      anrString: data.get(#anrString, or: $value.anrString),
      aInt: data.get(#aInt, or: $value.aInt),
      aDouble: data.get(#aDouble, or: $value.aDouble),
      aBool: data.get(#aBool, or: $value.aBool),
      aDateTime: data.get(#aDateTime, or: $value.aDateTime),
      aDuration: data.get(#aDuration, or: $value.aDuration));

  @override
  AllFields2CopyWith<$R2, AllFields2, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AllFields2CopyWithImpl<$R2, $Out2>($value, $cast, t);
}
