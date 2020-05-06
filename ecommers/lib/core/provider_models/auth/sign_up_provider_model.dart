import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class SignUpProviderModel extends ChangeNotifier with BusyNotifier {
  String email;
  String phoneNumber;
  String username;
  String password;

  List<AuthRichTextSpanModel> _bottomText;

  List<AuthRichTextSpanModel> get bottomText => _getBottomText();

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

  Future tryAuthorize() async {
    isBusy = true;

    final result = await authorizationService.createUserWithEmailAndPassword(
        email, password);
    _handleResult(result);

    isBusy = false;
  }

  Future autorizeWithPhoneNumber() async {
    if (!UserValidator.isPhoneNumber(phoneNumber)) return;

    isBusy = true;

    final result = await authorizationService.signInWithPhone('+$phoneNumber');
    _handleResult(result);

    isBusy = false;
  }

  Future _handleResult(AuthStatus result) async {
    switch (result) {
      case AuthStatus.success:
        await authorizationService.updateUserName(username);
        await navigationService.navigateWithReplacementTo(Pages.start);
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
}
