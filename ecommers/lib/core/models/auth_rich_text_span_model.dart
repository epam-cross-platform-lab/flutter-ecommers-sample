class AuthRichTextSpanModel {
  final String text;
  final bool isTappable;
  final Function() onTap;

  AuthRichTextSpanModel({
    this.text = '',
    this.isTappable = false,
    this.onTap,
  });
}