import 'package:ecommers/common/pages.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/consts.dart';
import 'package:flutter/material.dart';

class BottomNavigationWidget extends StatefulWidget {
  final Iterable<Pages> pages;
  final int selectedIndex;
  final Function(int) onTappedFunction;

  BottomNavigationWidget(
      {@required this.pages,
      @required this.selectedIndex,
      @required this.onTappedFunction});

  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _createBottomNavigationBarItems(),
      unselectedItemColor: Palette.bottomNavigationItemUnselected,
      selectedItemColor: Palette.bottomNavigationItemSelected,
      currentIndex: widget.selectedIndex,
      selectedLabelStyle: Styles.bottomnNavigationItemTitle,
      unselectedLabelStyle: Styles.bottomnNavigationItemTitle,
      iconSize: 18,
      showUnselectedLabels: true,  
      onTap: widget.onTappedFunction,
    );
  }

  _createBottomNavigationBarItems() {
    return widget.pages
        .map(
          (page) => BottomNavigationBarItem(
            icon: bottomNavigationItems[page].icon,
            title: Text(
              bottomNavigationItems[page].title,
            ),
          ),
        )
        .toList();
  }
}
