import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

class Flag {
  final String name;

  const Flag({required this.name});
}

const Flag basicFlag = Flag(name: "Basic Flag 42");

class Start {
  const Start();
}

mixin AMixin {}

abstract class AInterface {}

const Artifact art = Artifact(compression: true);

@art
@Flag(name: "This is A")
class A with AMixin implements AInterface {
  @basicFlag
  final int a;

  A({this.a = 42});

  @basicFlag
  @Start()
  void foo() {
    print("A.foo called!");
  }

  void bar() {}
}

@art
class B {
  int? mutableField;

  final int a;

  B({this.a = 42});
}

@basicFlag
@art
class C {
  final int a;

  C({this.a = 42});
}

@art
@Flag(name: "This is D")
@basicFlag
class D {
  final int a;

  D({this.a = 42});

  @Start()
  void ass() {
    print("D.ass called!");
  }

  @Start()
  void bad() {
    print("D.bad called!");
  }
}

void main() {
  // 1. Loop over all classes with @Flag annotation
  for ($AClass clazz in $artifactMirror.withAnnotation<Flag>().values) {
    // Create a new instance of this class
    Object instance = clazz.construct();

    // Find all methods in this class with the @Start annotation
    for ($AMth method in clazz.annotatedMethods<Start>()) {
      // Invoke the method with no parameters using the instance we just created
      method(instance, MethodParameters());
    }
  }
}
