import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/utils/dialog_manager.dart';
import 'package:flutter/material.dart';

class LogInProviderModel extends ProviderModelBase {
  List<AuthRichTextSpanModel> _bottomText;

  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

  LogInProviderModel(BuildContext context) : super(context);

  Future tryLogin(String username, String password) async {
    const String _usernameKey = 'username';
    const String _passwordKey = 'password';

    isBusy = true;

    final Response<LoginModel> response = await apiService.login({
      _usernameKey: username,
      _passwordKey: password,
    });

    isBusy = false;

    if (response.isSuccessful) {
      membershipService.refresh(response.body);
      await navigationService.navigateWithReplacementTo(Pages.shell);
      return;
    }

    await DialogManager.showAlertDialog(
        context, localization.alertTitle, localization.alertLoginText);
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
      ),
    ];
  }
}
