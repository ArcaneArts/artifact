import 'package:artifact/artifact.dart';

enum MemberRole { supervisor, systemOwner }

@artifact
class Test {
  final Set<MemberRole> roles;

  const Test({this.roles = const {}});
}
