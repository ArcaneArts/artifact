extension XMap<K, V> on Map<K, V> {
  bool $c(K key) => containsKey(key);

  Iterable<MapEntry<K, V>> get $e => entries;

  Map<K2, V2> $m<K2, V2>(MapEntry<K2, V2> convert(K key, V value)) =>
      map(convert);

  Map<K, V> get $nn {
    try {
      removeWhere((k, v) => v == null);
      return this;
    } catch (e) {}

    return {
      for (K k in keys)
        if (this[k] != null) k: this[k]!,
    };
  }
}

extension XIterable<V> on Iterable<V> {
  Iterable<J> $m<J>(J Function(V) f) => map(f);

  List<V> get $l => toList();

  Set<V> get $s => toSet();

  V? get $f => firstOrNull;
}

extension XList<V> on List<V> {
  List<V> $u(List<V>? a, List<V>? r) {
    if (a?.isNotEmpty ?? false) {
      return followedBy(a!).toList();
    }

    if (r?.isNotEmpty ?? false) {
      return this.where((i) => !r!.contains(i)).toList();
    }

    return this;
  }
}

extension XSet<V> on Set<V> {
  Set<V> $u(Set<V>? a, Set<V>? r) {
    if (a?.isNotEmpty ?? false) {
      return followedBy(a!).toSet();
    }

    if (r?.isNotEmpty ?? false) {
      return this.where((i) => !r!.contains(i)).toSet();
    }

    return this;
  }
}
