import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        resultPage = const CategoriesPage();
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
        final type = arguments as Categories;
        resultPage = ProductsGridPage(type: type);
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
