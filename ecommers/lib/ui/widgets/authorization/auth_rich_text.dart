import 'package:ecommers/core/models/index.dart';
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
  List<TapGestureRecognizer> _textTapRecognizerList;
  TextStyle baseTextStyle;

  @override
  void dispose() {
    _textTapRecognizerList.forEach(disposeRecognizer);
    super.dispose();
  }

  @override
  void initState() {
    _textTapRecognizerList = <TapGestureRecognizer>[];
    super.initState();
  }

  void disposeRecognizer(TapGestureRecognizer recognizer) {
    recognizer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    baseTextStyle = Theme.of(context).textTheme.bodyText2.copyWith(
          fontSize: FontSizes.small_3x,
        );

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
      children: <InlineSpan>[..._buildChildTextSpanList(childens)],
    );
  }

  TextSpan _buildTapableTextSpan(AuthRichTextSpanModel textModel,
      [List<AuthRichTextSpanModel> childens]) {
    return TextSpan(
      text: textModel.text,
      style: baseTextStyle.copyWith(color: BrandingColors.primary),
      recognizer: _getRecognizerFor(textModel),
      children: <InlineSpan>[..._buildChildTextSpanList(childens)],
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

  TapGestureRecognizer _getRecognizerFor(AuthRichTextSpanModel textModel) {
    if (!textModel.isTappable) return null;

    if (_textTapRecognizerList.isEmpty) {
      return _createRecognizer(textModel.onTap);
    }

    final recogizerIndex = widget.textSpanModelList
        .where((element) => element.isTappable)
        .toList()
        .indexOf(textModel);

    if (recogizerIndex < _textTapRecognizerList.length && recogizerIndex >= 0) {
      return _textTapRecognizerList[recogizerIndex];
    }

    return _createRecognizer(textModel.onTap);
  }

  TapGestureRecognizer _createRecognizer(Function() onTap) {
    final recognizer = TapGestureRecognizer()..onTap = onTap;
    _textTapRecognizerList.add(recognizer);

    return recognizer;
  }
}
