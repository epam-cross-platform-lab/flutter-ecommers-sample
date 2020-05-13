import 'package:ecommers/core/mixins/busy_notifier.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/cupertino.dart';

class ProfileProviderModel extends ChangeNotifier with BusyNotifier {
  String get email => profileService.user.email;

  String get emailOrPhone =>
      profileService.user.email ?? profileService.user.phoneNumber;

  String get name => profileService.user.displayName ?? emailOrPhone;

  String get phone => profileService.user.phoneNumber;

  Future saveChanges(String name) async {
    if (profileService.user.displayName != name) {
      isBusy = true;
      await authorizationService.updateUserName(name);
      await profileService.updateUserInfo();
      isBusy = false;

      notifyListeners();
    }

    navigationService.goBack();
  }

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
