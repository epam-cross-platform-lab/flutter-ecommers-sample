import 'package:flutter/widgets.dart';

class AuthRichTextSpanModel {
  final String text;
  final bool isTappable;
  final Function() onTap;
  final UniqueKey id = UniqueKey();

  AuthRichTextSpanModel({
    this.text = '',
    this.isTappable = false,
    this.onTap,
  });
}
