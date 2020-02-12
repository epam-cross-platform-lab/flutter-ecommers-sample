import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    var route = _generateRoute(page, arguments);
    return navigatorKey.currentState.push(route);
  }

  void goBack() {
    navigatorKey.currentState.pop();
  }

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    var resultPage;

    switch (page) {
      case Pages.shell:
        resultPage = ShellPage();
        break;
      case Pages.categories:
        resultPage = CategoriesPage();
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
