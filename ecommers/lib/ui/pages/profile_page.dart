import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:ecommers/ui/widgets/menu/menu_item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  static const List<MenuItemModel> _topMenuList = [
    MenuItemModel(
      svgAssetIconPath: ALL_ORDER_ICON,
      title: 'All My Orders',
    ),
    MenuItemModel(
      svgAssetIconPath: PENDING_SHIPMENT_ICON,
      title: 'Pending Shipments',
    ),
    MenuItemModel(
      svgAssetIconPath: PENDING_PAYMENT_ICON,
      title: 'Pending Payments',
    ),
    MenuItemModel(
      svgAssetIconPath: FINISHED_ORDERS_ICON,
      title: 'Finished Orders',
    ),
  ];

  static const List<MenuItemModel> _bottomMenuList = [
    MenuItemModel(
      svgAssetIconPath: INVITE_FRIENDS_ICON,
      title: 'Invite Friends',
    ),
    MenuItemModel(
      svgAssetIconPath: SUPPORT_ICON,
      title: 'Customer Support',
    ),
    MenuItemModel(
      svgAssetIconPath: RATE_APP_ICON,
      title: 'Rate Our App',
    ),
    MenuItemModel(
      svgAssetIconPath: SUGGEST_ICON,
      title: 'Make a Suggestion',
    ),
  ];

  static const EdgeInsets _listContainerMargin =
      EdgeInsets.symmetric(horizontal: Insets.x5);

  static const double _profileCardHeight = 100.0;
  static const double _profileCardEditButtonHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          _buildProfileCard(context),
          MenuList(
            margin: _listContainerMargin,
            itemList: _topMenuList,
          ),
          SizedBox(height: 15.0),
          MenuList(
            margin: _listContainerMargin,
            itemList: _bottomMenuList,
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      height: _profileCardHeight,
      margin: EdgeInsets.all(Insets.x6),
      child: Row(
        children: <Widget>[
          Container(
            height: _profileCardHeight,
            width: _profileCardHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(GIRL_IMAGE),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jane Doe', //TODO; get from the provider
                  maxLines: Dimens.defaultTextMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.profileNameText,
                ),
                Expanded(
                  child: Text(
                    'janedoe123@email.com', //TODO; get from the provider
                    maxLines: Dimens.defaultTextMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.profileEmailText,
                  ),
                ),
                _buildEditProfileButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return SizedBox(
      height: _profileCardEditButtonHeight,
      child: OutlineButton(
        borderSide: BorderSide(
          color: BrandingColors.secondary.withOpacity(0.3),
          width: 1.0,
        ),
        highlightedBorderColor: BrandingColors.secondary.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimens.buttonBorderRadius),
        ),
        child: Text(
          I18n.of(context).editProfile,
          style: Styles.profileButtonText,
        ),
        onPressed: () {},
      ),
    );
  }
}