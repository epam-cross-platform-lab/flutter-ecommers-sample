import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class MoreProviderModel extends ChangeNotifier with BusyNotifier {

   Future logOutPressHandler() async {
    await cacheDatabase.dropDataBase();
    authorizationService.logOut();
    await navigationService.navigateWithReplacementTo(Pages.authorization);
  }
}