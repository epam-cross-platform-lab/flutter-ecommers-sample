//import 'dart:js';

import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/right_menu_navigation/filter_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RightMenuNavigationService {
  final GlobalKey<NavigatorState> rightMenuNavigatorKey =
      GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(FilterPages filtersPage, {Object arguments}) {
    final route = _generateRoute(filtersPage, arguments);
    return rightMenuNavigatorKey.currentState.push(route);
  }

  void goBack() {
    rightMenuNavigatorKey.currentState.pop();
  }

  void goBackWithParams(int item) {
    rightMenuNavigatorKey.currentState.pop(item);
  }

  Route<dynamic> _generateRoute(FilterPages filtersPage, Object arguments) {
    Widget resultPage;

    switch (filtersPage) {
      case FilterPages.categories:
        resultPage =  RightMenuSecondPage(listFilterParametrs: arguments as List<String>,);
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
