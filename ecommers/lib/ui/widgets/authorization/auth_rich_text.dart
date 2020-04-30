import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRichText extends StatefulWidget {
  final List<AuthRichTextSpanModel> textSpanModelList;

  const AuthRichText({this.textSpanModelList});

  @override
  _AuthRichTextState createState() => _AuthRichTextState();
}

class _AuthRichTextState extends State<AuthRichText> {
  Map<UniqueKey, TapGestureRecognizer> _textTapRecognizerList;
  TextStyle baseTextStyle;

  @override
  void initState() {
    super.initState();

    _textTapRecognizerList = {
      for (var e in widget.textSpanModelList.where((e) => e.isTappable))
        e.id: TapGestureRecognizer()..onTap = e.onTap ?? () {}
    };

    baseTextStyle = textTheme.bodyText2.copyWith(fontSize: FontSizes.small_3x);
  }

  @override
  void dispose() {
    _textTapRecognizerList.values.forEach(disposeRecognizer);
    super.dispose();
  }

  void disposeRecognizer(TapGestureRecognizer recognizer) {
    recognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firstTextSpanModel = widget.textSpanModelList[0];
    final childTextSpanModelList = widget.textSpanModelList.skip(1).toList();

    return RichText(
      textAlign: TextAlign.center,
      text: _buildTextSpan(firstTextSpanModel, childTextSpanModelList),
    );
  }

  TextSpan _buildTextSpan(AuthRichTextSpanModel textModel,
      [List<AuthRichTextSpanModel> childens]) {
    return textModel.isTappable
        ? _buildTapableTextSpan(textModel, childens)
        : _buildDefaultTextSpan(textModel, childens);
  }

  TextSpan _buildDefaultTextSpan(AuthRichTextSpanModel textModel,
      [List<AuthRichTextSpanModel> childens]) {
    return TextSpan(
      text: textModel.text,
      style: baseTextStyle,
      children: [..._buildChildTextSpanList(childens)],
    );
  }

  TextSpan _buildTapableTextSpan(AuthRichTextSpanModel textModel,
      [List<AuthRichTextSpanModel> childens]) {
    return TextSpan(
      text: textModel.text,
      style: baseTextStyle.copyWith(color: BrandingColors.primary),
      recognizer: _textTapRecognizerList[textModel.id],
      children: [..._buildChildTextSpanList(childens)],
    );
  }

  Iterable<TextSpan> _buildChildTextSpanList(
      List<AuthRichTextSpanModel> childTextSpanModelList) sync* {
    if (childTextSpanModelList != null) {
      for (final item in childTextSpanModelList) {
        yield _buildTextSpan(item);
      }
    }
  }
}
