import 'package:cached_network_image/cached_network_image.dart';
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
      svgAssetIconPath: Assets.allOrderIcon,
      title: 'All My Orders',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.pendingShipmentIcon,
      title: 'Pending Shipments',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.pendingPaymentIcon,
      title: 'Pending Payments',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.finishedOrdersIcon,
      title: 'Finished Orders',
    ),
  ];

  static const List<MenuItemModel> _bottomMenuList = [
    MenuItemModel(
      svgAssetIconPath: Assets.inviteFriendsIcon,
      title: 'Invite Friends',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.supportIcon,
      title: 'Customer Support',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.rateAppIcon,
      title: 'Rate Our App',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.suggestIcon,
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
          const MenuList(
            margin: _listContainerMargin,
            itemList: _topMenuList,
          ),
          const SizedBox(height: 15.0),
          const MenuList(
            margin: _listContainerMargin,
            itemList: _bottomMenuList,
          ),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Widget _buildProfileCard(BuildContext context) {
    return Container(
      height: _profileCardHeight,
      margin: const EdgeInsets.all(Insets.x6),
      child: Row(
        children: <Widget>[
          Container(
            height: _profileCardHeight,
            width: _profileCardHeight,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                    '${Assets.imageBaseUrl}/${Assets.girlImage}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Jane Doe', //TODO: get from the provider
                  maxLines: Dimens.defaultTextMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Expanded(
                  child: Text(
                    'janedoe123@email.com', //TODO: get from the provider
                    maxLines: Dimens.defaultTextMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
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
          borderRadius: BorderRadius.circular(Radiuses.big_2x),
        ),
        onPressed: () {},
        child: Text(
          I18n.of(context).editProfile,
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }
}
