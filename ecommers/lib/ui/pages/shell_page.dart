import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/notifier_provider_widget.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ShellPage extends StatefulWidget {
  @override
  _ShellPageState createState() => _ShellPageState();
}

class _ShellPageState extends State<ShellPage> {
  @override
  Widget build(BuildContext context) {
    return NotifierProviderWidget(
      providerModel: ShellProviderModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
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
          body: _buildBody(model.selectedPage),
          bottomNavigationBar: BottomNavigationWidget(
            selectedIndex: model.selectedItemIndex,
            pages: model.pages,
            onTappedFunction: model.onTappedItem,
            orderCount: 3,
          ),
        );
      },
    );
  }

  Widget _buildBody(Pages pageType) {
    var page = _getBody(pageType);

    return OrientationBuilder(
      builder: (context, orientation) => orientation == Orientation.portrait
          ? page
          : BackgroundedSafeArea(child: page, isBottom: false),
    );
  }

  Widget _getBody(Pages pageType) {
    switch (pageType) {
      case Pages.home:
        return HomePage();
      case Pages.search:
        return SearchPage();
      case Pages.cart:
        return CartPage();
      case Pages.profile:
        return ProfilePage();
      case Pages.more:
        return MorePage();
      default:
        return HomePage();
    }
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
