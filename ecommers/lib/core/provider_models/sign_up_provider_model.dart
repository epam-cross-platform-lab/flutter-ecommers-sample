import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/data/repository/firebase_repository.dart';
import 'package:flutter/material.dart';

class SignUpProviderModel extends ProviderModelBase {
  String email;
  String phoneNumber;
  String username;
  String password;

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

  Future tryAuthorize() async {
    isBusy = true;

    final result = await authorizationService.createUserWithEmailAndPassword(
        email, password);
    _handleResult(result);

    isBusy = false;
  }

  Future autorizeWithPhoneNumber() async {
    isBusy = true;

    final result = await authorizationService.signInWithPhone(phoneNumber);
    _handleResult(result);

    isBusy = false;
  }

  Future _handleResult(AuthStatus result) async {
    switch (result) {
      case AuthStatus.success:
        await authorizationService.updateUserName(username);
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
        dialogService.showDialog(
            header: 'Unknown error',
            body: 'Something go wrong. Please retry later',
            confirmText: 'OK');
        break;
      default:
        break;
    }
  }
}
