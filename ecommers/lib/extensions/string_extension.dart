extension StringExtension on String {
  bool get isNullOrEmpty => this == null || isEmpty;
}