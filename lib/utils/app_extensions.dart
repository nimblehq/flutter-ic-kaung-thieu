extension IteratorExtensions<E> on Iterable<E> {
  E? get firstOrNull {
    Iterator<E> it = iterator;
    if (!it.moveNext()) {
      return null;
    }
    return it.current;
  }
}
