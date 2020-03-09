import 'package:flutter/widgets.dart';

extension StringExtension on String {
  bool get isNullOrEmpty => this == null || isEmpty;

  Color fromHexToColor() {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
