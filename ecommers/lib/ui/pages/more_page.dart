import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MorePage extends StatelessWidget {
  static const List<MenuItemModel> topMenuList = [
    MenuItemModel(
      svgAssetIconPath: SHIPPING_ICON,
      title: 'Shipping Adress',
    ),
    MenuItemModel(
      svgAssetIconPath: PAYMENT_ICON,
      title: 'Payment Method',
    ),
    MenuItemModel(
      svgAssetIconPath: CURRENCY_ICON,
      title: 'Currency',
      subTitle: 'USD',
    ),
    MenuItemModel(
      svgAssetIconPath: LANGUAGE_ICON,
      title: 'Language',
      subTitle: 'ENGLISH',
    ),
  ];
  static const List<MenuItemModel> bottomMenuList = [
    MenuItemModel(
      svgAssetIconPath: BELL_ICON,
      title: 'Notification Settings',
    ),
    MenuItemModel(
      svgAssetIconPath: SHIELD_ICON,
      title: 'Privacy Policy',
    ),
    MenuItemModel(
      svgAssetIconPath: DISCUSS_ISSUE_ICON,
      title: 'Frequently Asked Questions',
    ),
    MenuItemModel(
      svgAssetIconPath: CHECK_FORM_ICON,
      title: 'Legal Information',
    ),
  ];

  static const EdgeInsets menuListMargin =
      EdgeInsets.symmetric(horizontal: 20.0);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
            child: Text(
              I18n.of(context).morePage,
              style: Styles.titleText,
            ),
          ),
          SizedBox(height: 35.0),
          MenuList(
            margin: menuListMargin,
            itemList: topMenuList,
          ),
          SizedBox(height: 15.0),
          MenuList(
            margin: menuListMargin,
            itemList: bottomMenuList,
          ),
          SizedBox(height: 40.0),
          _buildLogOutButton(context),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }

  Widget _buildLogOutButton(BuildContext context) {
    return Center(
      child: CupertinoButton(
        child: Text(
          I18n.of(context).logOut,
          style: Styles.logOutButtonText,
        ),
        onPressed: () {},
      ),
    );
  }
}
