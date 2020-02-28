import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:flutter/material.dart';

class SignUpProviderModel extends ProviderModelBase {
  List<AuthRichTextSpanModel> _bottomText;

  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

  SignUpProviderModel(BuildContext context) : super(context);

  List<AuthRichTextSpanModel> _getBottomText() {
    return _bottomText ??= [
      AuthRichTextSpanModel(
        text: localization.signUpBottomTextSpan1,
        isTappable: false,
      ),
      AuthRichTextSpanModel(
        text: localization.signUpBottomTextSpan2,
        isTappable: true,
      ),
      AuthRichTextSpanModel(
        text: localization.signUpBottomTextSpan3,
        isTappable: false,
      ),
      AuthRichTextSpanModel(
        text: localization.signUpBottomTextSpan4,
        isTappable: true,
      ),
    ];
  }
}
