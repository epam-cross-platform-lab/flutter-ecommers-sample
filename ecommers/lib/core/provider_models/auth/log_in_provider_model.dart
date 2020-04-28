import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:flutter/material.dart';

class LogInProviderModel extends ChangeNotifier with BusyNotifier {
  String userName;
  String phoneNumber;
  String password;
  Function bottomTapCallback;
  List<AuthRichTextSpanModel> _bottomText;
  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

  LogInProviderModel({this.bottomTapCallback});

  Future login() async {
    if (!UserValidator.isPasswordValid(userName)) return;
    isBusy = true;

    final result = await authorizationService.signInWithEmailAndPassword(
        userName, password);
    await _handleResult(result);

    isBusy = false;
  }

  Future phoneLogin() async {
    if (!UserValidator.isPhoneNumber(phoneNumber)) return;

    isBusy = true;

    final result = await authorizationService.signInWithPhone('+$phoneNumber');
    await _handleResult(result);

    isBusy = false;
  }

  Future _handleResult(AuthStatus result) async {
    switch (result) {
      case AuthStatus.success:
        await navigationService.navigateWithReplacementTo(Pages.shell);
        break;
      case AuthStatus.timeout:
        dialogService.showDialog(
            header: localization.enter_sms_code_dialogTitle,
            body: localization.sms_code_timeout_dialogDescription,
            confirmText: localization.sms_code_timeout_dialogPrimary_button);
        break;
      case AuthStatus.verificationFailed:
        dialogService.showDialog(
            header: localization.verification_dialogTitle,
            body: localization.verification_dialogDescription,
            confirmText: localization.verification_dialogPrimary_button);
        break;
      default:
        dialogService.somethingWentWrong();
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
