import 'package:flutter/widgets.dart';

extension StringExtension on String {
  bool get isNullOrEmpty => this == null || isEmpty;
  bool get isNotNullOrEmpty => this != null && isNotEmpty;

  Color fromHexToColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
