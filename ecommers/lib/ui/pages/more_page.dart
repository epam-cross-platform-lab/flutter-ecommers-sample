import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MorePage extends StatelessWidget {
  static final List<MenuItemModel> topMenuList = [
    MenuItemModel(
      svgAssetIconPath: Assets.shippingIcon,
      title: 'Shipping Adress',
      onTappedFunction: () =>
          navigationService.navigateTo(Pages.shippingAddress),
    ),
    const MenuItemModel(
      svgAssetIconPath: Assets.paymentIcon,
      title: 'Payment Method',
    ),
    const MenuItemModel(
      svgAssetIconPath: Assets.currencyIcon,
      title: 'Currency',
      subTitle: 'USD',
    ),
    const MenuItemModel(
      svgAssetIconPath: Assets.languageIcon,
      title: 'Language',
      subTitle: 'ENGLISH',
    ),
  ];
  static const List<MenuItemModel> bottomMenuList = [
    MenuItemModel(
      svgAssetIconPath: Assets.bellIcon,
      title: 'Notification Settings',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.shieldIcon,
      title: 'Privacy Policy',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.discussIssueIcon,
      title: 'Frequently Asked Questions',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.checkFormIcon,
      title: 'Legal Information',
    ),
  ];

  static const EdgeInsets menuListMargin =
      EdgeInsets.symmetric(horizontal: Insets.x5);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      createProvider: () => MoreProviderModel(),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
              child: Text(
                localization.morePage,
                style: textTheme.headline6,
              ),
            ),
            const SizedBox(height: 35.0),
            MenuList(
              margin: menuListMargin,
              itemList: topMenuList,
            ),
            const SizedBox(height: 15.0),
            const MenuList(
              margin: menuListMargin,
              itemList: bottomMenuList,
            ),
            const SizedBox(height: 40.0),
            _buildLogOutButton(),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _buildLogOutButton() {
    return Consumer<MoreProviderModel>(
      builder: (_, provider, __) {
        return Center(
          child: CupertinoButton(
            onPressed: provider.logOutPressHandler,
            child: Text(
              localization.logOut,
              style:
                  textTheme.headline5.copyWith(color: BrandingColors.primary),
            ),
          ),
        );
      },
    );
  }
}
