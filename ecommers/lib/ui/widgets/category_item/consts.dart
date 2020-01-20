import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

import 'category_item_model.dart';

const boxShadowOffset = Offset(0, 2);

  const labelPadding = EdgeInsets.all(10);
  const apparelImagePadding = EdgeInsets.all(14);
  const beautyImagePadding = EdgeInsets.symmetric(vertical: 14, horizontal: 17);
  const shoesImagePadding = EdgeInsets.symmetric(vertical: 18, horizontal: 14);
  const electronicsImagePadding = EdgeInsets.symmetric(vertical: 16, horizontal: 12);
  const furnitureImagePadding = EdgeInsets.all(12.5);
  const homeImagePadding = EdgeInsets.symmetric(vertical: 15, horizontal: 14);
  const stationaryImagePadding = EdgeInsets.symmetric(vertical: 12.5, horizontal: 13.5);

final categoryButtons = {
  Categories.apparel: CategoryItemModel(
      gradient: Gradients.apparelCategory,
      shadowColor: Palette.apparelCategoryShadow,
      imagePath: APPAREL_ICON,
      imageCategoryPadding: apparelImagePadding,
      title: "Apparel"
  ),
  Categories.beauty: CategoryItemModel(
      gradient: Gradients.beautyCategory,
      shadowColor: Palette.beautyCategoryShadow,
      imagePath: BEAUTY_ICON,
      imageCategoryPadding: beautyImagePadding,
      title: "Apparel"
  ),
  Categories.shoes: CategoryItemModel(
    gradient: Gradients.shoesCategory,
    shadowColor: Palette.shoesCategoryShadow,
    imagePath: SHOES_ICON,
    imageCategoryPadding: shoesImagePadding,
    title: "Apparel"

  ),
  Categories.electronics: CategoryItemModel(
      gradient: Gradients.electronicsCategory,
      shadowColor: Palette.electronicsCategoryShadow,
      imagePath: ELECTRONICS_ICON,
      imageCategoryPadding: electronicsImagePadding,
      title: "Apparel"
  ),
  Categories.furniture: CategoryItemModel(
      gradient: Gradients.furnitureCategory,
      shadowColor: Palette.furnitureCategoryShadow,
      imagePath: FURNITURE_ICON,
      imageCategoryPadding: furnitureImagePadding,
      title: "Apparel"
  ),
  Categories.home: CategoryItemModel(
      gradient: Gradients.homeCategory,
      shadowColor: Palette.homeCategoryShadow,
      imagePath: HOME_ICON,
      imageCategoryPadding: homeImagePadding,
      title: "Apparel"
  ),
  Categories.stationary: CategoryItemModel(
      gradient: Gradients.stationaryCategory,
      shadowColor: Palette.stationaryCategoryShadow,
      imagePath: STATIONARY_ICON,
      imageCategoryPadding: stationaryImagePadding,
      title: "Apparel"
  ),
};
