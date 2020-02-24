import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  static const List<MenuItemModel> topMenuList = [
    MenuItemModel(
      svgAssetIconPath: Assets.shippingIcon,
      title: 'Shipping Adress',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.paymentIcon,
      title: 'Payment Method',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.currencyIcon,
      title: 'Currency',
      subTitle: 'USD',
    ),
    MenuItemModel(
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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
            child: Text(
              I18n.of(context).morePage,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          const SizedBox(height: 35.0),
          const MenuList(
            margin: menuListMargin,
            itemList: topMenuList,
          ),
          const SizedBox(height: 15.0),
          const MenuList(
            margin: menuListMargin,
            itemList: bottomMenuList,
          ),
          const SizedBox(height: 40.0),
          _buildLogOutButton(context),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
    return Center(
      child: CupertinoButton(
        onPressed: logOutPressHandler,
        child: Text(
          I18n.of(context).logOut,
          style: Theme.of(context)
              .textTheme
              .headline5
              .apply(color: BrandingColors.primary),
        ), //TODO use proovider
      ),
    );
  }

  Future logOutPressHandler() async {
    await membershipService.clear(); 
    await navigationService.navigateWithReplacementTo(Pages.authorization);
  }
}
