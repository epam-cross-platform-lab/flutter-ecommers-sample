import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:flutter/material.dart';

class ShellProviderModel extends ProviderModelBase {
  final List<Pages> pages = [
    Pages.home,
    Pages.search,
    Pages.cart,
    Pages.profile,
    Pages.more
  ];

  int selectedItemIndex = 0;

  ShellProviderModel(BuildContext context) : super(context);

  Pages get selectedPage => pages[selectedItemIndex];

  void onTappedItem(int index) {
    selectedItemIndex = index;
    notifyListeners();
  }
}
