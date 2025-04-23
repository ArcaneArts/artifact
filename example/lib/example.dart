import 'dart:convert';

import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

@artifact
class AllFields {
  final AnyEnum? e;

  @codec(RemoteCodec())
  final Remote remoteClass;

  final int x;
  final String? str;
  final double doub;
  final dynamic something;
  final List<dynamic> somethings;
  final Map<String, dynamic> mappedSomethings;
  final Map<String, int> test;

  const AllFields({
    this.something,
    this.somethings = const [],
    this.test = const {},
    this.mappedSomethings = const {},
    required this.remoteClass,
    this.e = AnyEnum.a,
    required this.x,
    this.str,
    this.doub = 3,
  });
}

class Remote {
  final int i;
  const Remote(this.i);
}

class RemoteCodec extends ArtifactCodec<int, Remote> {
  const RemoteCodec();
  @override
  Remote? decode(int? value) => value == null ? null : Remote(value);

  @override
  int? encode(Remote? value) => value?.i;
}

enum AnyEnum { a, b, c, d }

void main() {
  print(
    jsonEncode(
      jsonDecode(
        AllFields(
          x: -6,
          something: "astring",
          somethings: [4, 3.4, "string"],
          mappedSomethings: {
            "astring": "astring",
            "astring2": 3,
            "astring3": 4.5,
          },
          remoteClass: Remote(7),
          e: AnyEnum.c,
        ).toJson(),
      ),
    ),
  );
}
