import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/buttom_bar_item_icon.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/consts.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  final Iterable<Pages> pages;
  final int selectedIndex;
  final Function(int) onTappedFunction;
  final int orderCount;

  BottomNavigationWidget({
    @required this.pages,
    @required this.selectedIndex,
    @required this.onTappedFunction,
    this.orderCount = 0,
  });

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _createBottomNavigationBarItems(),
      unselectedItemColor: BrandingColors.primaryText,
      selectedItemColor: BrandingColors.primary,
      currentIndex: widget.selectedIndex,
      selectedLabelStyle: Theme.of(context).textTheme.caption,
      unselectedLabelStyle: Theme.of(context).textTheme.caption,
      iconSize: 26.0,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: widget.onTappedFunction,
    );
  }

  List<BottomNavigationBarItem> _createBottomNavigationBarItems() {
    return widget.pages
        .map(
          (page) => BottomNavigationBarItem(
            icon: ButtomBarItemIcon(
              iconData: bottomNavigationItems[page].icon,
              hasBadge: page == Pages.cart,
              badgeValue: page == Pages.cart ? widget.orderCount : 0,
            ),
            title: Text(bottomNavigationItems[page].title),
          ),
        )
        .toList();
  }
}
