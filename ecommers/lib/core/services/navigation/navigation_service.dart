import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/page_arguments.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/pages/notifications_page.dart';
import 'package:ecommers/ui/pages/product_page.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    Widget resultPage;

    switch (page) {
      case Pages.shell:
        resultPage = ShellPage();
        break;
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
          categoryType: productGridArguments.arg1 as Categories,
          subCategory: productGridArguments.arg2 as String,
        );
        break;
      case Pages.product:
        resultPage = const ProductPage();
        break;
      case Pages.notifications:
        resultPage = NotificationsPage();
        break;
      default:
        resultPage = ShellPage();
        break;
    }

    return _getRoute(resultPage);
  }

  Route<dynamic> _getRoute(Widget widget) {
    return CupertinoPageRoute(builder: (_) => widget);
  }
}
