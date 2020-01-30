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

    const String _notificationsImagePath = NOTIFICATIONS_ICON;
    const String _messagesImagePath = MESSAGES_ICON;

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: shellProvider.appBarColor,
        actions: <Widget>[
          _buildAction(
            imageAssetPath: _messagesImagePath,
            onIconPressedFuction: () {},
            badgeValue: 5,
          ),
          _buildAction(
            imageAssetPath: _notificationsImagePath,
            onIconPressedFuction: () {},
            badgeValue: 6,
          ),
        ],
      ),
      backgroundColor: Palette.pageBackground,
      body: shellProvider.body,
      bottomNavigationBar: BottomNavigationWidget(
        selectedIndex: shellProvider.selectedItemIndex,
        pages: shellProvider.pages,
        onTappedFunction: shellProvider.onTappedItem,
        orderCount: 8,
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
        badgeValue: badgeValue, //TODO get from provider
        icon: SvgPicture.asset(imageAssetPath),
      ),
      onPressed: onIconPressedFuction,
    );
  }
}
