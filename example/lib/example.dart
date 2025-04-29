import 'package:artifact/artifact.dart';

@artifact
class User {
  final int x;

  const User({required this.x});
}

@artifact
class Test {
  final List<User>? usersNL;
  final List<User> usersL;
  final Set<User> usersS;
  final Set<User>? usersNS;
  final Map<String, User> usersM;
  final Map<String, User>? usersNM;

  const Test({
    this.usersNL = const [],
    this.usersL = const [],
    this.usersS = const {},
    this.usersNS = const {},
    this.usersM = const {},
    this.usersNM = const {},
  });
}
