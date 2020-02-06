import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

import 'category_item_model.dart';

const double labelBottomMargin = 5;
Color apparelShadowColor = Color(0xffFF6262).withOpacity(0.34);
Color beautyShadowColor = Color(0xff62AAFF).withOpacity(0.35);
Color shoesShadowColor = Color(0xff26D555).withOpacity(0.34);
Color electronicsShadowColor = Color(0xff7A71E8).withOpacity(0.34);
Color furnitureShadowColor = Color(0xffD59F26).withOpacity(0.34);
Color homeShadowColor = Color(0xff834162).withOpacity(0.34);
Color stationaryShadowColor = Color(0xff646464).withOpacity(0.34);

final categoryItems = {
  Categories.apparel: CategoryItemModel(
    gradient: Gradients.apparelCategory,
    shadowColor: apparelShadowColor,
    imagePath: APPAREL_ICON,
    title: "Apparel",
  ),
  Categories.beauty: CategoryItemModel(
    gradient: Gradients.beautyCategory,
    shadowColor: beautyShadowColor,
    imagePath: BEAUTY_ICON,
    title: "Apparel",
  ),
  Categories.shoes: CategoryItemModel(
    gradient: Gradients.shoesCategory,
    shadowColor: shoesShadowColor,
    imagePath: SHOES_ICON,
    title: "Apparel",
  ),
  Categories.electronics: CategoryItemModel(
    gradient: Gradients.electronicsCategory,
    shadowColor: electronicsShadowColor,
    imagePath: ELECTRONICS_ICON,
    title: "Apparel",
  ),
  Categories.furniture: CategoryItemModel(
    gradient: Gradients.furnitureCategory,
    shadowColor: furnitureShadowColor,
    imagePath: FURNITURE_ICON,
    title: "Apparel",
  ),
  Categories.home: CategoryItemModel(
    gradient: Gradients.homeCategory,
    shadowColor: homeShadowColor,
    imagePath: HOME_ICON,
    title: "Apparel",
  ),
  Categories.stationary: CategoryItemModel(
    gradient: Gradients.stationaryCategory,
    shadowColor: stationaryShadowColor,
    imagePath: STATIONARY_ICON,
    title: "Apparel",
  ),
};
