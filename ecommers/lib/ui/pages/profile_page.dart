import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/profile_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:ecommers/ui/widgets/menu/menu_item_model.dart';
import 'package:ecommers/ui/widgets/profile/profile_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  static final List<MenuItemModel> _topMenuList = [
    const MenuItemModel(
      svgAssetIconPath: Assets.allOrderIcon,
      title: 'All My Orders',
    ),
    const MenuItemModel(
      svgAssetIconPath: Assets.pendingShipmentIcon,
      title: 'Pending Shipments',
    ),
    MenuItemModel(
      svgAssetIconPath: Assets.pendingPaymentIcon,
      title: 'Pending Payments',
      onTappedFunction: () => navigationService.navigateTo(Pages.paymentMethod),
    ),
    const MenuItemModel(
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

  static const double _profileCardHeight = Insets.x25;
  static const double _profileCardEditButtonHeight = 30.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProviderModel>(
      builder: (_, ProfileProviderModel model, __) {
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              _buildProfileCard(model),
              MenuList(
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
      },
    );
  }

  Widget _buildProfileCard(ProfileProviderModel model) {
    return Container(
      height: _profileCardHeight,
      margin: const EdgeInsets.all(Insets.x6),
      child: Row(
        children: <Widget>[
          const ProfileImage(_profileCardHeight),
          const SizedBox(width: 20.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.getName(),
                  maxLines: Dimens.defaultTextMaxLines,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.headline6,
                ),
                Expanded(
                  child: Text(
                    model.getEmailOrPhone(),
                    maxLines: Dimens.defaultTextMaxLines,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyText1,
                  ),
                ),
                _buildEditProfileButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditProfileButton() {
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
        onPressed: () => navigationService.navigateTo(Pages.profileEdit),
        child: Text(
          localization.editProfile.toUpperCase(),
          style: textTheme.button,
        ),
      ),
    );
  }
}
