import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:flutter/material.dart';

class ShellProviderModel extends ChangeNotifier with BusyNotifier {
  final List<Pages> pages = [
    Pages.home,
    Pages.search,
    Pages.cart,
    Pages.profile,
    Pages.more
  ];

  int selectedItemIndex = 0;

  Pages get selectedPage => pages[selectedItemIndex];

  void onTappedItem(int index) {
    selectedItemIndex = index;
    notifyListeners();
  }
}
