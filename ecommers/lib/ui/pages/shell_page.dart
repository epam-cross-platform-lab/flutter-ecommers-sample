import 'package:ecommers/providers/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: shellProvider.appBarColor,
        brightness: Brightness.light,
        actions: <Widget>[
          _buildAction(
            imageAssetPath: MESSAGES_ICON,
            onIconPressedFuction: () {}, //TODO get from provider
            badgeValue: 5, //TODO get from provider
          ),
          _buildAction(
            imageAssetPath: NOTIFICATIONS_ICON,
            onIconPressedFuction: () {}, //TODO get from provider
            badgeValue: 6, //TODO get from provider
          ),
        ],
      ),
      backgroundColor: BrandingColors.pageBackground,
      body: shellProvider.body,
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: shellProvider.selectedItemIndex,
        pages: shellProvider.pages,
        onTappedFunction: shellProvider.onTappedItem,
        orderCount: 3, //TODO get from provider
      ),
    );
  }

  Widget _buildAction({
    String imageAssetPath,
    Function onIconPressedFuction,
    int badgeValue,
  }) {
    return IconButton(
      icon: IconWithBadge(
        badgeValue: badgeValue,
        badgeTextStyle: Theme.of(context).textTheme.overline,
        icon: SvgPicture.asset(imageAssetPath),
      ),
      onPressed: onIconPressedFuction,
    );
  }
}