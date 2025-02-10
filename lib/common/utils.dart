void updateFromMap<K, V>(
  Map<K, V> target,
  Map<K, V> source,
  V Function(V oldValue, V newValue) update,
) {
  source.forEach((key, newValue) {
    if (target.containsKey(key)) {
      // Если ключ уже существует, обновляем значение
      target[key] = update(target[key]!, newValue);
    } else {
      // Если ключа нет, добавляем новое значение
      target[key] = newValue;
    }
  });
}
