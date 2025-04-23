extension XMap<K, V> on Map<K, V> {
  bool $c(K key) => containsKey(key);

  Iterable<MapEntry<K, V>> get $e => entries;
}

extension XIterable<V> on Iterable<V> {
  Iterable<J> $m<J>(J Function(V) f) => map(f);
}
