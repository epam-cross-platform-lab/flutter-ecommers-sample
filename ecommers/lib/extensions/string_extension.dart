import 'package:flutter/widgets.dart';

extension ColorFromHex on String {
  Color fromHex(){
    final buffer = StringBuffer();
  if (length == 6 || length == 7) buffer.write('ff');
  buffer.write(replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));
  }
  
}