import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/cupertino.dart';

class ProfileProviderModel extends ChangeNotifier {
  String get email => profileService.user.email;

  String get emailOrPhone =>
      profileService.user.email ?? profileService.user.phoneNumber;

  String get name => profileService.user.displayName ?? emailOrPhone;

  String get phone => profileService.user.phoneNumber;

  Future saveChanges(String name) async {
    if (profileService.user.displayName != name) {
      await authorizationService.updateUserName(name);
      await profileService.updateUserInfo();

      notifyListeners();
    }

    navigationService.goBack();
  }
}
