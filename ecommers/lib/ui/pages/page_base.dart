import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageBase extends StatelessWidget {
  final Widget body;
  final Color appBarBackgroundColor;
  final bool hasVerticalScrolling;

  static const String _notificationsImagePath = NOTIFICATIONS_IMAGE;
  static const String _messagesImagePath = MESSAGES_IMAGE;

  const PageBase({
    @required this.body,
    this.appBarBackgroundColor,
    this.hasVerticalScrolling = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: appBarBackgroundColor ?? Palette.pageBackground,
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
      body: _buildBody(),
      backgroundColor: Palette.pageBackground,
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

  Widget _buildBody() {
    return hasVerticalScrolling
        ? SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: body,
          )
        : body;
  }
}
