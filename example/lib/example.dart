import 'package:artifact/artifact.dart';
import 'package:example/gen/artifacts.gen.dart';

const model = Artifact(reflection: true, compression: false);

@model
class SomeFunctionalThing {
  @EventHandler(ignoreCancelled: false)
  void on(DerpEvent event) {
    print(
      "SomeFunctionalThing ${event.message} isCancelled: ${event.cancelled}",
    );
  }
}

@model
class SomePriorityThing {
  @EventHandler(priority: EventPriority.high)
  void on(DerpEvent event) {
    print("SomePriorityThing ${event.message}");
    event.cancel();
  }
}

class DerpEvent extends ArtifactEvent with CancellableEvent {
  final String message;

  DerpEvent(this.message);
}

void main() {
  $SomeFunctionalThing.fromMap({});

  // Use an event manager (there will be a centralized one eventually)
  EventManager mgr = EventManager();

  // Make the object instances
  SomeFunctionalThing a = SomeFunctionalThing();
  SomePriorityThing b = SomePriorityThing();

  // Register the listeners for the objects
  mgr.registerListeners(a);
  mgr.registerListeners(b);

  // Yeet an event into the abyss
  DerpEvent event = DerpEvent("Hello, World!");
  mgr.callEvent(event);
}
