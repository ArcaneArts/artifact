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
