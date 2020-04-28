import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class ForgotPasswordProviderModel extends ChangeNotifier with BusyNotifier {
  Future resetPassword(String email) async {
    isBusy = true;
    final result = await authorizationService.restorePassword(email);
    isBusy = false;

    if (result) {
      dialogService.showDialog(
          header: localization.password_restoration_dialogTitle,
          body: localization.password_restoration_dialogDescription,
          confirmText: localization.password_restoration_dialogPrimary_button);
    } else {
      dialogService.somethingWentWrong();
    }
  }
}
