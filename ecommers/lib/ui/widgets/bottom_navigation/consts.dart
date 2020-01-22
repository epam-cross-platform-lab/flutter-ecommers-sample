import 'package:ecommers/common/pages.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:flutter/material.dart';

final bottomNavigationItems = {
  Pages.home: BottomNavigationItemModel(icon: Icon(Icons.home), title: 'Home'),
  Pages.search: BottomNavigationItemModel(icon: Icon(Icons.search), title: 'Search'),
  Pages.cart: BottomNavigationItemModel(icon: Icon(Icons.shopping_cart), title: 'Cart'),
  Pages.profile: BottomNavigationItemModel(icon: Icon(Icons.person_outline), title: 'Profile'),
  Pages.more: BottomNavigationItemModel(icon: Icon(Icons.menu), title: 'More'),
};
