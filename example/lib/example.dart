import 'dart:convert';

import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@artifact
class AllFields {
  final int finalX;
  final int finalDefX;
  final int? nullX;
  final int? defX;

  const AllFields({
    required this.finalX,
    this.nullX,
    this.defX = 4,
    this.finalDefX = 99,
  });
}

void main() {
  print(jsonEncode(jsonDecode(AllFields(finalX: 19).toJson())));

  AllFields f = AllFields(finalX: 10);
}
