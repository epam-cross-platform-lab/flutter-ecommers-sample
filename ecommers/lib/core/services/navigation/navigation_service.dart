import 'package:ecommers/core/models/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/core/models/page_arguments.dart';
import 'package:get/get.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = Get.key;

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.push(route);
  }

  Future<dynamic> navigateWithReplacementTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return navigatorKey.currentState.pushReplacement(route);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }

  void goBackToShell({int index = 0}) {
    navigatorKey.currentState.popUntil((Route<dynamic> route) {
      return route.settings?.name == StartPage.route;
    });

    Provider.of<ShellProviderModel>(navigatorKey.currentContext, listen: false)
        .onTappedItem(index);
  }

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    Widget resultPage;
    RouteSettings settings;

    switch (page) {
      case Pages.categories:
        resultPage = CategoriesPage(categories: arguments as List<Category>);
        break;
      case Pages.authorization:
        resultPage = const AuthorizationPage();
        break;
      case Pages.checkout:
        resultPage = CheckoutPage();
        break;
      case Pages.success:
        resultPage = const SuccessPage();
        break;
      case Pages.productsGrid:
        final productGridArguments = arguments as PageArguments;
        resultPage = ProductsGridPage(
          categoryType: productGridArguments?.arg1 as Categories,
          subCategory: productGridArguments?.arg2 as String,
        );
        break;
      case Pages.product:
        if (arguments is Product) {
          resultPage = ProductPage(productModel: arguments);
          break;
        }
        final productPageArguments = arguments as PageArguments;
        resultPage = ProductPage(
          productModel: productPageArguments?.arg1 as Product,
          withHeroAniamtion: productPageArguments?.arg2 as bool,
        );
        break;
      case Pages.notifications:
        resultPage = NotificationsPage();
        break;
      case Pages.note:
        final model = arguments as Note;
        resultPage = NotePage(model: model);
        break;
      case Pages.paymentMethod:
        resultPage = PaymentMethodPage();
        break;
      case Pages.addPaymentMethod:
        resultPage = AddPaymentMethodPage();
        break;
      case Pages.shippingAddress:
        resultPage = ShippingAddressPage();
        break;
      case Pages.addShippingAddress:
        resultPage = AddShippingAddress(shippingAddres: arguments as ShippingAddressModel,);
        break;
      case Pages.start:
        resultPage = StartPage();
        settings = const RouteSettings(name: StartPage.route);
        break;
      default:
        resultPage = StartPage();
        break;
    }

    return _getRoute(resultPage, settings: settings);
  }

  Route<dynamic> _getRoute(Widget widget, {RouteSettings settings}) {
    return CupertinoPageRoute(builder: (_) => widget, settings: settings);
  }
}
