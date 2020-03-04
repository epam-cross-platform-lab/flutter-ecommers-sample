import 'package:chopper/chopper.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/login_model.dart';
import 'package:ecommers/core/models/user_model.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/ui/utils/dialog_manager.dart';
import 'package:flutter/material.dart';

class SignUpProviderModel extends ProviderModelBase {
  String email;
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

    final userJson = UserModel(username, email, password).toJson();
    final Response<LoginModel> response = await apiService.auth(userJson);

    isBusy = false;

    if (response.isSuccessful) {
      membershipService.refresh(response.body);
      await navigationService.navigateWithReplacementTo(Pages.shell);
      return;
    }

    await DialogManager.showAlertDialog(
        context, localization.alertTitle, response.bodyString);
  }
}
