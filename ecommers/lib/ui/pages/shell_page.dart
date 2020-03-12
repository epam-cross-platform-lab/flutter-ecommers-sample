import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShellProviderModel(context)),
        ChangeNotifierProvider(create: (_) => ProductsGridProviderModel(context))
      ],
          child: ChangeNotifierProvider(
        create: (_) => ShellProviderModel(context),
        child: Consumer<ShellProviderModel>(
          builder: (context, ShellProviderModel model, child) {
            return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  _buildAction(
                    imageAssetPath: Assets.messagesIcon,
                    onIconPressedFuction: () {}, //TODO get from provider
                    badgeValue: 5, //TODO get from provider
                    context: context,
                  ),
                  _buildAction(
                    imageAssetPath: Assets.notificationIcon,
                    onIconPressedFuction: () {}, //TODO get from provider
                    badgeValue: 6, //TODO get from provider
                    context: context,
                  ),
                ],
              ),
              backgroundColor: BrandingColors.pageBackground,
              body: BackgroundedSafeArea(
                child: _buildBody(model.selectedPage),
              ),
              bottomNavigationBar: BottomNavigationWidget(
                selectedIndex: model.selectedItemIndex,
                pages: model.pages,
                onTappedFunction: model.onTappedItem,
                orderCount: 3,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBody(Pages pageType) {
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
    Function() onIconPressedFuction,
    int badgeValue,
    BuildContext context,
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
