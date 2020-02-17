import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class AuthRichText extends StatefulWidget {
  final List<AuthRichTextSpanModel> textSpanModelList;

  AuthRichText({this.textSpanModelList});

  @override
  _AuthRichTextState createState() => _AuthRichTextState();
}

class _AuthRichTextState extends State<AuthRichText> {
  List<TapGestureRecognizer> _textTapRecognizerList;
  TextStyle baseTextStyle;

  @override
  void dispose() {
    _textTapRecognizerList.forEach((element) => element.dispose());
    super.dispose();
  }

  @override
  void initState() {
    _textTapRecognizerList = List<TapGestureRecognizer>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    baseTextStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: FontSizes.small_3x,
        );

    var firstTextSpanModel = widget.textSpanModelList[0];
    var childTextSpanModelList = widget.textSpanModelList.skip(1).toList();

    return RichText(
      textAlign: TextAlign.center,
      text: _buildTextSpan(firstTextSpanModel)
        ..children.addAll(_buildChildTextSpanList(childTextSpanModelList)),
    );
  }

  TextSpan _buildTextSpan(AuthRichTextSpanModel textModel) {
    return textModel.isTappable
        ? _buildTapableTextSpan(textModel)
        : _buildDefaultTextSpan(textModel);
  }

  TextSpan _buildDefaultTextSpan(AuthRichTextSpanModel textModel) {
    return TextSpan(
      text: textModel.text,
      style: baseTextStyle,
      children: <InlineSpan>[],
    );
  }

  TextSpan _buildTapableTextSpan(AuthRichTextSpanModel textModel) {
    return TextSpan(
      text: textModel.text,
      style: baseTextStyle.copyWith(color: BrandingColors.primary),
      recognizer: _getRecognizerFor(textModel),
      children: <InlineSpan>[],
    );
  }

  TapGestureRecognizer _getRecognizerFor(AuthRichTextSpanModel textModel) {
    if (!textModel.isTappable) return null;

    if (_textTapRecognizerList.isEmpty)
      return _createRecognizer(textModel.onTap);

    var recogizerIndex = widget.textSpanModelList
        .where((element) => element.isTappable)
        .toList()
        .indexOf(textModel);

    if (recogizerIndex < _textTapRecognizerList.length && recogizerIndex >= 0)
      return _textTapRecognizerList[recogizerIndex];

    return _createRecognizer(textModel.onTap);
  }

  TapGestureRecognizer _createRecognizer(Function onTap) {
    var recognizer = TapGestureRecognizer()..onTap = onTap;
    _textTapRecognizerList.add(recognizer);

    return recognizer;
  }

  Iterable<TextSpan> _buildChildTextSpanList(
      List<AuthRichTextSpanModel> childTextSpanModelList) sync* {
    for (var item in childTextSpanModelList) {
      yield _buildTextSpan(item);
    }
  }
}
