import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/pages/authorization/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/pages/notifications_page.dart';
import 'package:ecommers/ui/pages/product_page.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightMenuNavigationService {
  final GlobalKey<NavigatorState> rightMenuNavigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    final route = _generateRoute(page, arguments);
    return rightMenuNavigatorKey.currentState.push(route);
  }

  void goBack() {
    rightMenuNavigatorKey.currentState.pop();
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
      case Pages.product:
        resultPage = const ProductPage();
        break;
      case Pages.notifications:
        resultPage = NotificationsPage();
        break;
      case Pages.rightMenuSecondPage:
        final listFilterParametrs = arguments as List<String>;
        resultPage =
            RightMenuSecondPage(listFilterParametrs: listFilterParametrs);
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
