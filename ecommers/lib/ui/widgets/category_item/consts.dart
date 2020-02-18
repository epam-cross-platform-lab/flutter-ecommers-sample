import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

import 'category_item_model.dart';

const double labelBottomMargin = 5;
Color apparelShadowColor = const Color(0xffFF6262).withOpacity(0.34);
Color beautyShadowColor = const Color(0xff62AAFF).withOpacity(0.35);
Color shoesShadowColor = const Color(0xff26D555).withOpacity(0.34);
Color electronicsShadowColor = const Color(0xff7A71E8).withOpacity(0.34);
Color furnitureShadowColor = const Color(0xffD59F26).withOpacity(0.34);
Color homeShadowColor = const Color(0xff834162).withOpacity(0.34);
Color stationaryShadowColor = const Color(0xff646464).withOpacity(0.34);

final Map<Categories, CategoryItemModel> categoryItems = {
  Categories.apparel: CategoryItemModel(
    gradient: Gradients.apparelCategory,
    shadowColor: apparelShadowColor,
    imagePath: Assets.apparelIcon,
    title: 'Apparel',
  ),
  Categories.beauty: CategoryItemModel(
    gradient: Gradients.beautyCategory,
    shadowColor: beautyShadowColor,
    imagePath: Assets.beautyIcon,
    title: 'Apparel',
  ),
  Categories.shoes: CategoryItemModel(
    gradient: Gradients.shoesCategory,
    shadowColor: shoesShadowColor,
    imagePath: Assets.shoesIcon,
    title: 'Apparel',
  ),
  Categories.electronics: CategoryItemModel(
    gradient: Gradients.electronicsCategory,
    shadowColor: electronicsShadowColor,
    imagePath: Assets.electronicsIcon,
    title: 'Apparel',
  ),
  Categories.furniture: CategoryItemModel(
    gradient: Gradients.furnitureCategory,
    shadowColor: furnitureShadowColor,
    imagePath: Assets.furnitureIcon,
    title: 'Apparel',
  ),
  Categories.home: CategoryItemModel(
    gradient: Gradients.homeCategory,
    shadowColor: homeShadowColor,
    imagePath: Assets.homeIcon,
    title: 'Apparel',
  ),
  Categories.stationary: CategoryItemModel(
    gradient: Gradients.stationaryCategory,
    shadowColor: stationaryShadowColor,
    imagePath: Assets.stationaryIcon,
    title: 'Apparel',
  ),
};
