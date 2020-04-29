import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class MoreProviderModel extends ProviderModelBase {
  MoreProviderModel(BuildContext context) : super(context) ;

  

   Future logOutPressHandler() async {
    await cacheDatabase.dropDataBase([
      CacheDefines.latestProducts,
      CacheDefines.orders,
      CacheDefines.paymentMethods,
      CacheDefines.categories,
    ]);
    authorizationService.logOut();
    await navigationService.navigateWithReplacementTo(Pages.authorization);
  }
}