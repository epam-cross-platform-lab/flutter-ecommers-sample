import 'package:ecommers/common/pages.dart';
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

  void onTappedItem(int index) {
    selectedItemIndex = index;
    notifyListeners();
  }

  Widget createBody() {
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
      default: return HomePage();
    }
  }
}
