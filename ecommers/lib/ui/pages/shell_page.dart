import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/cart_provider.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/bottom_navigation/bottom_navigation_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShellPage extends StatelessWidget {
  static const route = '/shell';

  @override
  Widget build(BuildContext context) {
    Provider.of<CartProvider>(context, listen: false).initializeOrderProducts();
    Provider.of<ShippingAddressProviderModel>(context, listen: false).initialize();
    Provider.of<PaymentMethodProviderModel>(context, listen: false).initialize();
    
    return Consumer<ShellProviderModel>(
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
                onIconPressedFuction: () => navigationService
                    .navigateTo(Pages.notifications), //TODO get from provider
                badgeValue: 6, //TODO get from provider
                context: context,
              ),
            ],
          ),
          backgroundColor: BrandingColors.pageBackground,
          body: BackgroundedSafeArea(
            child: IndexedStack(
                index: model.selectedItemIndex,
                children: <Widget>[
                  HomePage(),
                  SearchPage(),
                  CartPage(),
                  ProfilePage(),
                  MorePage()
                ]),
          ),
          bottomNavigationBar: BottomNavigationWidget(
            selectedIndex: model.selectedItemIndex,
            pages: model.pages,
            onTappedFunction: model.onTappedItem,
          ),
        );
      },
    );
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
        badgeTextStyle: textTheme.overline,
        icon: SvgPicture.asset(imageAssetPath),
      ),
      onPressed: onIconPressedFuction,
    );
  }
}
