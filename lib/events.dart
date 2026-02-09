import 'package:artifact/artifact.dart';

final EventManager $events = EventManager();

class EventManager {
  static EventManager get instance => $events;

  Map<Type, List<EventListener>> listeners = {};

  void callEvent(ArtifactEvent event) {
    for (EventListener i in listeners[event.runtimeType] ?? []) {
      if (event is CancellableEvent &&
          (event as CancellableEvent).cancelled &&
          i.annotation.ignoreCancelled) {
        continue;
      }

      i.handler(event);
    }
  }

  void unregisterListeners(Object instance) {
    for (MapEntry<Type, List<EventListener<ArtifactEvent>>> entry
        in listeners.entries) {
      entry.value.removeWhere(
        (listener) => identical(listener.instance, instance),
      );
    }
  }

  void unregisterAll() => listeners.clear();

  void unregisterAllListeningOn(Type eventType) => listeners.remove(eventType);

  void registerListeners(Object instance) {
    $AClass? clazz = ArtifactAccessor.reflectObject(instance);

    if (clazz != null) {
      for ($AMth i in clazz.annotatedMethods<EventHandler>()) {
        Type? eventType = i.orderedParameterTypes.firstOrNull;

        if (eventType == null || eventType == ArtifactEvent) {
          throw Exception(
            "Event handler methods must have at least one parameter which is the event object extending ArtifactEvent.",
          );
        }
        listeners[eventType] ??= [];
        listeners[eventType]!.add(
          EventListener(
            instance: instance,
            annotation: i.annotationOf<EventHandler>()!,
            handler:
                // Link to method call of provided event
                (e) => i(instance, MethodParameters(orderedParameters: [e])),
          ),
        );

        listeners[eventType]!.sort(
          (a, b) => b.annotation.priority.index.compareTo(
            a.annotation.priority.index,
          ),
        );
      }
    }
  }
}

class EventListener<T extends ArtifactEvent> {
  final Object instance;
  final EventHandler annotation;
  final void Function(T event) handler;

  EventListener({
    required this.instance,
    required this.annotation,
    required this.handler,
  });
}

class ArtifactEvent {}

mixin CancellableEvent {
  bool cancelled = false;

  void cancel() {
    cancelled = true;
  }
}

class EventHandler {
  final bool ignoreCancelled;
  final EventPriority priority;

  const EventHandler({
    this.priority = EventPriority.normal,
    this.ignoreCancelled = true,
  });
}

const EventHandler eventHandler = EventHandler();

enum EventPriority { lowest, low, normal, high, highest }
