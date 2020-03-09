import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return const Text('Search');
    return Scaffold(endDrawer: RightMenuWidget(),);
  }
}
