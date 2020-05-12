import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class ResetPasswordProviderModel extends ChangeNotifier with BusyNotifier {
  Future resetPassword(String email) async {
    isBusy = true;
    final result = await authorizationService.restorePassword(email);
    isBusy = false;

    if (result) {
      dialogService.showDialog(
          header: localization.password_reset_dialogTitle,
          body: localization.password_reset_dialogDescription,
          confirmText: localization.password_reset_dialogPrimary_button);
    } else {
      dialogService.somethingWentWrong();
    }
  }
}
