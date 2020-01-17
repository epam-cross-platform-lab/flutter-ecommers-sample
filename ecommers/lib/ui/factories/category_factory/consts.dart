import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/models/category_button_model.dart';

final categoryButtons = {
  Categories.apparel: CategoryButtonModel(
      gradient: Gradients.apparelCategory,
      shadowColor: Palette.apparelCategoryShadow,
      imagePath: APPAREL_ICON,
      imageCategoryPadding: Dimens.apparelImagePadding
  ),
  Categories.beauty: CategoryButtonModel(
      gradient: Gradients.beautyCategory,
      shadowColor: Palette.beautyCategoryShadow,
      imagePath: BEAUTY_ICON,
      imageCategoryPadding: Dimens.beautyImagePadding
  ),
  Categories.shoes: CategoryButtonModel(
    gradient: Gradients.shoesCategory,
    shadowColor: Palette.shoesCategoryShadow,
    imagePath: SHOES_ICON,
    imageCategoryPadding: Dimens.shoesImagePadding,
  ),
  Categories.electronics: CategoryButtonModel(
      gradient: Gradients.electronicsCategory,
      shadowColor: Palette.electronicsCategoryShadow,
      imagePath: ELECTRONICS_ICON,
      imageCategoryPadding: Dimens.electronicsImagePadding
  ),
  Categories.furniture: CategoryButtonModel(
      gradient: Gradients.furnitureCategory,
      shadowColor: Palette.furnitureCategoryShadow,
      imagePath: FURNITURE_ICON,
      imageCategoryPadding: Dimens.furnitureImagePadding
  ),
  Categories.home: CategoryButtonModel(
      gradient: Gradients.homeCategory,
      shadowColor: Palette.homeCategoryShadow,
      imagePath: HOME_ICON,
      imageCategoryPadding: Dimens.homeImagePadding
  ),
  Categories.stationary: CategoryButtonModel(
      gradient: Gradients.stationaryCategory,
      shadowColor: Palette.stationaryCategoryShadow,
      imagePath: STATIONARY_ICON,
      imageCategoryPadding: Dimens.stationaryImagePadding
  ),
};
