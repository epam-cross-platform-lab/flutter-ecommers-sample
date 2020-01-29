import 'package:ecommers/providers/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatefulWidget {
  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    final shellProvider = Provider.of<ShellProvider>(context);

    return Scaffold(
      body: shellProvider.createBody(),
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: shellProvider.selectedItemIndex,
        pages: shellProvider.pages,
        onTappedFunction: shellProvider.onTappedItem,
        orderCount: 3,
      ),
    );
  }
}
