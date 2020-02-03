import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

import 'category_item_model.dart';

const double labelBottomMargin = 5;
Color apparelCategoryShadow = Color(0xffFF6262).withOpacity(0.34);
Color beautyCategoryShadow = Color(0xff62AAFF).withOpacity(0.35);
Color shoesCategoryShadow = Color(0xff26D555).withOpacity(0.34);
Color electronicsCategoryShadow = Color(0xff7A71E8).withOpacity(0.34);
Color furnitureCategoryShadow = Color(0xffD59F26).withOpacity(0.34);
Color homeCategoryShadow = Color(0xff834162).withOpacity(0.34);
Color stationaryCategoryShadow = Color(0xff646464).withOpacity(0.34);

final categoryItems = {
  Categories.apparel: CategoryItemModel(
    gradient: Gradients.apparelCategory,
    shadowColor: apparelCategoryShadow,
    imagePath: APPAREL_ICON,
    title: "Apparel",
  ),
  Categories.beauty: CategoryItemModel(
    gradient: Gradients.beautyCategory,
    shadowColor: beautyCategoryShadow,
    imagePath: BEAUTY_ICON,
    title: "Apparel",
  ),
  Categories.shoes: CategoryItemModel(
    gradient: Gradients.shoesCategory,
    shadowColor: shoesCategoryShadow,
    imagePath: SHOES_ICON,
    title: "Apparel",
  ),
  Categories.electronics: CategoryItemModel(
    gradient: Gradients.electronicsCategory,
    shadowColor: electronicsCategoryShadow,
    imagePath: ELECTRONICS_ICON,
    title: "Apparel",
  ),
  Categories.furniture: CategoryItemModel(
    gradient: Gradients.furnitureCategory,
    shadowColor: furnitureCategoryShadow,
    imagePath: FURNITURE_ICON,
    title: "Apparel",
  ),
  Categories.home: CategoryItemModel(
    gradient: Gradients.homeCategory,
    shadowColor: homeCategoryShadow,
    imagePath: HOME_ICON,
    title: "Apparel",
  ),
  Categories.stationary: CategoryItemModel(
    gradient: Gradients.stationaryCategory,
    shadowColor: stationaryCategoryShadow,
    imagePath: STATIONARY_ICON,
    title: "Apparel",
  ),
};
