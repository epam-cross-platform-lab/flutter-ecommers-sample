import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightMenuNavigationService {
  final GlobalKey<NavigatorState> rightMenuNavigatorKey =
      GlobalKey<NavigatorState>();

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
        resultPage = const RightMenuSecondPage();
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
