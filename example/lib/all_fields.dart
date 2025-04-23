import 'package:dart_mappable/dart_mappable.dart';

part 'all_fields.mapper.dart';

@MappableClass()
class AllFields2 with AllFields2Mappable {
  final String aString;
  final String? anString;
  final String? anrString;
  final int aInt;
  final double aDouble;
  final bool aBool;
  final DateTime aDateTime;
  final Duration aDuration;

  const AllFields2({
    this.aString = "",
    this.anString,
    this.anrString = "",
    this.aInt = 0,
    this.aDouble = 0.0,
    this.aBool = false,
    required this.aDateTime,
    this.aDuration = const Duration(),
  });
}
