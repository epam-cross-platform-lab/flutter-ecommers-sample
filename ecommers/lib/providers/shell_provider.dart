import 'package:ecommers/common/pages.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:flutter/material.dart';

class ShellProvider with ChangeNotifier {
  final List<Pages> pages = [
    Pages.home,
    Pages.search,
    Pages.cart,
    Pages.profile,
    Pages.more
  ];

  int selectedItemIndex = 0;

  Color get appBarColor  => _getAppBarColor();
  Widget get body => _createBody();

  void onTappedItem(int index) {
    selectedItemIndex = index;
    notifyListeners();
  }

  Widget _createBody() {
    var page = pages[selectedItemIndex];
    switch (page) {
      case Pages.home:
        return HomePage();
      case Pages.search:
        return SearchPage();
      case Pages.cart:
        return CartPage();
      case Pages.profile:
        return ProfilePage();
      case Pages.more:
        return MorePage();
      default:
        return HomePage();
    }
  }

  Color _getAppBarColor() {
    switch (pages[selectedItemIndex]) {
      case Pages.home:
        return Palette.homeAppBarBackground;
      default:
        return Palette.pageBackground;
    }
  }
}
