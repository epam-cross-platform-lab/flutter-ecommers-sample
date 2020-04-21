import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:ecommers/ui/utils/dialog_manager.dart';
import 'package:flutter/material.dart';

class LogInProviderModel extends ProviderModelBase {
  String userName;
  String password;
  Function bottomTapCallback;
  List<AuthRichTextSpanModel> _bottomText;
  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

  LogInProviderModel(BuildContext context, {this.bottomTapCallback})
      : super(context);

  Future login() async {
    if (!UserValidator.isPasswordValid(userName)) return;

    isBusy = true;

    final result = await authorizationService.signInWithEmailAndPassword(
        userName, password);
    await handleResult(result);

    isBusy = false;
  }

  Future phoneLogin() async {
    if (!UserValidator.isPhoneNumber(userName)) return;

    isBusy = true;

    final result = await authorizationService.signInWithPhone(userName);
    await handleResult(result);

    isBusy = false;
  }

  Future handleResult(AuthStatus result) async {
    switch (result) {
      case AuthStatus.success:
        await navigationService.navigateWithReplacementTo(Pages.shell);
        break;
      case AuthStatus.timeout:
        dialogService.showDialog(
            header: 'Timeout exceeded',
            body: 'Timeout exceeded',
            confirmText: 'OK');
        break;
      case AuthStatus.verificationFailed:
        dialogService.showDialog(
            header: 'Verification failed',
            body: 'Check your login or password and try again',
            confirmText: 'OK');
        break;
      case AuthStatus.unknown:
        break;
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
