import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_item_model.dart';
import 'package:flutter/material.dart';

final bottomNavigationItems = {
  Pages.home: BottomNavigationItemModel(icon: Icons.home, title: 'Home'),
  Pages.search: BottomNavigationItemModel(icon: Icons.search, title: 'Search'),
  Pages.cart: BottomNavigationItemModel(icon: Icons.shopping_cart, title: 'Cart'),
  Pages.profile: BottomNavigationItemModel(icon: Icons.person_outline, title: 'Profile'),
  Pages.more: BottomNavigationItemModel(icon: Icons.menu, title: 'More'),
};
