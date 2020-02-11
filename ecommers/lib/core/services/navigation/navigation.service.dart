import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Pages page, {Object arguments}) {
    var route = _generateRoute(page, arguments);
    return navigatorKey.currentState.push(route);
  }

  Route<dynamic> _generateRoute(Pages page, Object arguments) {
    var resultPage;
    
    switch (page) {
      case Pages.shell:
      default:
          resultPage = ShellPage();
          break;
    }

    return _getRoute(resultPage);
  }

  Route<dynamic> _getRoute(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }
}
