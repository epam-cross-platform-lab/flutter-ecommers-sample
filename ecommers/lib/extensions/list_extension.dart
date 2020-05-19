extension ListExtension<T> on List<T> {
  T getItem(int index) {
    if(this == null || index >= length) return null;

    return this[index];
  }
}