import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/utils/dialog_manager.dart';
import 'package:flutter/material.dart';

class LogInProviderModel extends ProviderModelBase {
  String usernameOrEmail;
  String password;
  Function bottomTapCallback;

  List<AuthRichTextSpanModel> _bottomText;
  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

  LogInProviderModel(BuildContext context) : super(context);

  Future tryLogin() async {
    isBusy = true;

    final isSuccessful =
        await authorizationService.tryLogin(usernameOrEmail, password);

    isBusy = false;

    if (isSuccessful) {
      await navigationService.navigateWithReplacementTo(Pages.shell);
    } else {
      await DialogManager.showAlertDialog(
          context, localization.alertTitle, localization.alertLoginText);
    }
  }

  List<AuthRichTextSpanModel> _getBottomText() {
    return _bottomText ??= [
      AuthRichTextSpanModel(
        text: localization.loginBottomTextSpan1,
        isTappable: false,
      ),
      AuthRichTextSpanModel(
        text: localization.loginBottomTextSpan2,
        isTappable: true,
        onTap: () => {
          if (bottomTapCallback != null)
            {
              bottomTapCallback(),
            },
        },
      ),
    ];
  }
}
