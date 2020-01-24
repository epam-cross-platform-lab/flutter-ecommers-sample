import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/index.dart';

import 'category_item_model.dart';

const double labelBottomMargin = 5;

final categoryItems = {
  Categories.apparel: CategoryItemModel(
      gradient: Gradients.apparelCategory,
      shadowColor: Palette.apparelCategoryShadow,
      imagePath: APPAREL_ICON,
      title: "Apparel"
  ),
  Categories.beauty: CategoryItemModel(
      gradient: Gradients.beautyCategory,
      shadowColor: Palette.beautyCategoryShadow,
      imagePath: BEAUTY_ICON,
      title: "Apparel"
  ),
  Categories.shoes: CategoryItemModel(
    gradient: Gradients.shoesCategory,
    shadowColor: Palette.shoesCategoryShadow,
    imagePath: SHOES_ICON,
    title: "Apparel"
  ),
  Categories.electronics: CategoryItemModel(
      gradient: Gradients.electronicsCategory,
      shadowColor: Palette.electronicsCategoryShadow,
      imagePath: ELECTRONICS_ICON,
      title: "Apparel"
  ),
  Categories.furniture: CategoryItemModel(
      gradient: Gradients.furnitureCategory,
      shadowColor: Palette.furnitureCategoryShadow,
      imagePath: FURNITURE_ICON,
      title: "Apparel"
  ),
  Categories.home: CategoryItemModel(
      gradient: Gradients.homeCategory,
      shadowColor: Palette.homeCategoryShadow,
      imagePath: HOME_ICON,
      title: "Apparel"
  ),
  Categories.stationary: CategoryItemModel(
      gradient: Gradients.stationaryCategory,
      shadowColor: Palette.stationaryCategoryShadow,
      imagePath: STATIONARY_ICON,
      title: "Apparel"
  ),
};
