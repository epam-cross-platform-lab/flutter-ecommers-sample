import 'package:ecommers/core/models/edit_profile_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/cupertino.dart';

class ProfileProviderModel extends ChangeNotifier {
  String getEmailOrPhone() {
    return profileService.user.email ?? profileService.user.phoneNumber;
  }

  String getName() {
    return profileService.user.displayName ?? getEmailOrPhone();
  }

  String getPhone() {
    return profileService.user.phoneNumber;
  }

  Future updateProfileInfo(EditProfileModel model) async {
    if (profileService.user.displayName == model.name) {
      return;
    }

    authorizationService.updateUserName(model.name);
    await profileService.updateUserInfo();
    notifyListeners();
  }
}
