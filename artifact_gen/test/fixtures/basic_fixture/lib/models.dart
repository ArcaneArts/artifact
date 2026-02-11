import 'package:artifact/artifact.dart';

const bool _compression = false;
const Artifact plainArtifact = Artifact(compression: _compression);
const Artifact reflectArtifact = Artifact(
  compression: _compression,
  reflection: true,
);
const Artifact schemaArtifact = Artifact(
  compression: _compression,
  generateSchema: true,
);

class Compact {
  final int raw;

  const Compact(this.raw);
}

class CompactCodec extends ArtifactCodec<int, Compact> {
  const CompactCodec();

  @override
  Compact? decode(int? value) => value == null ? null : Compact(value);

  @override
  int? encode(Compact? value) => value?.raw;
}

class Property {
  final double? max;
  final double? min;
  final String? hint;
  final String? description;
  final bool? tristate;
  final String? label;
  final bool obscuredText;
  final List<ManifoldValidator> validators;

  const Property({
    this.max,
    this.min,
    this.hint,
    this.description,
    this.tristate,
    this.label,
    this.obscuredText = false,
    this.validators = const <ManifoldValidator>[],
  });
}

@plainArtifact
class FixtureBase {
  final int id;

  const FixtureBase({this.id = 1});
}

@plainArtifact
class FixtureChild extends FixtureBase {
  final String name;

  const FixtureChild({super.id = 2, this.name = 'child'});
}

@plainArtifact
class FixtureZoo {
  final List<FixtureBase> items;

  const FixtureZoo({this.items = const <FixtureBase>[]});
}

@plainArtifact
class FixtureModel {
  @rename('v')
  final int value;

  final String label;

  @codec(CompactCodec())
  final Compact compact;

  const FixtureModel({
    this.value = 4,
    this.label = 'label',
    this.compact = const Compact(9),
  });
}

@reflectArtifact
class ReflectFixture {
  final int count;

  const ReflectFixture({this.count = 1});
}

@schemaArtifact
class SchemaFixture {
  @rename('identifier')
  final int id;

  final bool active;

  const SchemaFixture({this.id = 1, this.active = true});
}

class EverythingAnnotation {
  final String aString;
  final int aInt;
  final double aDouble;
  final List<bool> aBools;
  final Map<String, dynamic> aRawMap;
  final Map<String, String>? aStringMapN;
  final List<String>? aStringListN;
  final Set<AConstThing> aConstThings;

  const EverythingAnnotation({
    this.aString = 'default',
    this.aInt = 42,
    this.aDouble = 3.14,
    this.aBools = const [true, false],
    this.aRawMap = const {'key': 'value'},
    this.aStringMapN,
    this.aStringListN,
    this.aConstThings = const {AConstThing()},
  });
}

class AConstThing {
  final List<String> aL;
  final int? x;

  const AConstThing({this.aL = const ['a', 'b', 'c'], this.x});
}

@EverythingAnnotation()
@reflectArtifact
class ReflectAnnotationVisibility {
  @EverythingAnnotation()
  final String someField;

  @EverythingAnnotation()
  final int? someInt;

  const ReflectAnnotationVisibility({this.someField = 'field', this.someInt});

  @EverythingAnnotation()
  int doSomething(int a, int b) => a + b;
}

enum AnEnum { option1, option2, option3 }

@reflectArtifact
class ASubObject {
  final String value;
  final int anotherValue;

  const ASubObject({this.value = "something", this.anotherValue = 42});
}

@reflectArtifact
class RootObject {
  final String aString;
  final String? aNullableString;
  final int anInt;
  final int? aNullableInt;
  final double aDouble;
  final DateTime aDateTime;
  final DateTime? aNullableDateTime;
  final bool aBool;
  final bool? aNullableBool;
  final List<String> aListOfStrings;
  final List<String>? aNullableListOfStrings;
  final Set<String> aSetOfStrings;
  final Set<String>? aNullableSetOfStrings;
  final List<String?> aListOfNullableStrings;
  final Set<String?> aSetOfNullableStrings;
  final AnEnum anEnum;
  final AnEnum? aNullableEnum;
  final List<AnEnum> aListOfEnums;
  final Set<AnEnum> aSetOfEnums;
  final ASubObject aSubObject;
  final ASubObject? aNullableSubObject;
  final List<ASubObject> aListOfSubObjects;
  final Set<ASubObject> aSetOfSubObjects;
  final List<ASubObject?> aListOfNullableSubObjects;
  final Set<ASubObject?> aSetOfNullableSubObjects;
  final Map<String, int> aMapOfStringToInt;
  final Map<String, ASubObject> aMapOfStringToSubObject;
  final Map<String, List<String>> aMapOfStringToListOfStrings;
  final Map<String, List<ASubObject>> aMapOfStringToListOfSubObjects;
  final Map<String, ASubObject?> aMapOfStringToNullableSubObject;
  final Map<String, String?> aMapOfStringToNullableString;

  RootObject({
    required this.aString,
    this.aNullableString,
    required this.anInt,
    this.aNullableInt,
    required this.aDouble,
    required this.aDateTime,
    this.aNullableDateTime,
    required this.aBool,
    this.aNullableBool,
    required this.aListOfStrings,
    this.aNullableListOfStrings,
    required this.aSetOfStrings,
    this.aNullableSetOfStrings,
    required this.aListOfNullableStrings,
    required this.aSetOfNullableStrings,
    required this.anEnum,
    this.aNullableEnum,
    required this.aListOfEnums,
    required this.aSetOfEnums,
    required this.aSubObject,
    this.aNullableSubObject,
    required this.aListOfSubObjects,
    required this.aSetOfSubObjects,
    required this.aListOfNullableSubObjects,
    required this.aSetOfNullableSubObjects,
    required this.aMapOfStringToInt,
    required this.aMapOfStringToSubObject,
    required this.aMapOfStringToListOfStrings,
    required this.aMapOfStringToListOfSubObjects,
    required this.aMapOfStringToNullableSubObject,
    required this.aMapOfStringToNullableString,
  });
}

@reflectArtifact
class TestModel {
  @Property(validators: [EmailValidator(message: "Bad Email")])
  final String name;

  const TestModel({this.name = ""});
}

class ManifoldValidationContext {
  final ArtifactFieldMirror field;
  final Object? value;

  const ManifoldValidationContext({required this.field, required this.value});
}

abstract class ManifoldValidator {
  const ManifoldValidator();

  String? validate(ManifoldValidationContext context);
}

class RequiredValidator extends ManifoldValidator {
  final String? message;

  const RequiredValidator({this.message});

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return message ?? '${context.field.name} is required.';
    }

    if (value is String && value.trim().isEmpty) {
      return message ?? '${context.field.name} is required.';
    }

    if (value is Iterable && value.isEmpty) {
      return message ?? '${context.field.name} is required.';
    }

    if (value is Map && value.isEmpty) {
      return message ?? '${context.field.name} is required.';
    }

    return null;
  }
}

class RegexValidator extends ManifoldValidator {
  final String pattern;
  final String? message;
  final bool caseSensitive;
  final bool multiLine;
  final bool unicode;
  final bool dotAll;
  final bool allowEmpty;

  const RegexValidator(
    this.pattern, {
    this.message,
    this.caseSensitive = true,
    this.multiLine = false,
    this.unicode = false,
    this.dotAll = false,
    this.allowEmpty = true,
  });

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return null;
    }

    String text = value.toString();
    if (text.isEmpty && allowEmpty) {
      return null;
    }

    RegExp exp = RegExp(
      pattern,
      caseSensitive: caseSensitive,
      multiLine: multiLine,
      unicode: unicode,
      dotAll: dotAll,
    );

    return exp.hasMatch(text)
        ? null
        : (message ?? '${context.field.name} is invalid.');
  }
}

class EmailValidator extends RegexValidator {
  const EmailValidator({String? message})
    : super(
        r'^[^\s@]+@[^\s@]+\.[^\s@]+$',
        message: message ?? 'Invalid email address.',
      );
}

class PhoneValidator extends ManifoldValidator {
  final int minDigits;
  final int maxDigits;
  final String? message;

  const PhoneValidator({
    this.minDigits = 10,
    this.maxDigits = 15,
    this.message,
  });

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return null;
    }

    String text = value.toString().trim();
    if (text.isEmpty) {
      return null;
    }

    String digits = text.replaceAll(RegExp(r'[^0-9]'), '');
    bool ok = digits.length >= minDigits && digits.length <= maxDigits;
    return ok ? null : (message ?? 'Invalid phone number.');
  }
}

class MinLengthValidator extends ManifoldValidator {
  final int min;
  final String? message;

  const MinLengthValidator(this.min, {this.message});

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return null;
    }

    int length = _lengthOf(value);
    if (length < 0) {
      return null;
    }

    return length >= min
        ? null
        : (message ?? '${context.field.name} must be at least $min long.');
  }
}

class MaxLengthValidator extends ManifoldValidator {
  final int max;
  final String? message;

  const MaxLengthValidator(this.max, {this.message});

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return null;
    }

    int length = _lengthOf(value);
    if (length < 0) {
      return null;
    }

    return length <= max
        ? null
        : (message ?? '${context.field.name} must be at most $max long.');
  }
}

class NumberRangeValidator extends ManifoldValidator {
  final double? min;
  final double? max;
  final String? message;

  const NumberRangeValidator({this.min, this.max, this.message});

  @override
  String? validate(ManifoldValidationContext context) {
    Object? value = context.value;
    if (value == null) {
      return null;
    }

    double? n = _asDouble(value);
    if (n == null) {
      return message ?? '${context.field.name} must be a number.';
    }

    if (min != null && n < min!) {
      return message ?? '${context.field.name} must be >= $min.';
    }

    if (max != null && n > max!) {
      return message ?? '${context.field.name} must be <= $max.';
    }

    return null;
  }
}

double? _asDouble(Object value) {
  if (value is num) {
    return value.toDouble();
  }

  return double.tryParse(value.toString());
}

int _lengthOf(Object value) {
  if (value is String) {
    return value.length;
  }

  if (value is Iterable) {
    return value.length;
  }

  if (value is Map) {
    return value.length;
  }

  return -1;
}
