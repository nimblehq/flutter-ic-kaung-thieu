extension NullableStringExtension on String? {
  String orEmpty() {
    return this ?? '';
  }
}
