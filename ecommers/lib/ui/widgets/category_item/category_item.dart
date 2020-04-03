import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../extensions/index.dart';

class CategoryItem extends StatelessWidget {
  final Gradient labelBackgroundGradient;
  final Color shadowColor;
  final Color backgroundColor;
  final String imagePath;
  final String title;
  final Function() onTapFunction;

  static const size = Size(74.0, 89.0);
  static const categoryLabelSize = 65.0;

  const CategoryItem({
    @required this.shadowColor,
    @required this.imagePath,
    @required this.title,
    this.labelBackgroundGradient,
    this.backgroundColor,
    this.onTapFunction,
  });

  factory CategoryItem.fromType(
    Categories categoryType,
    Function(Categories) onTap,
  ) {
    final categoryItem = categoryItems[categoryType];

    return CategoryItem(
      labelBackgroundGradient: categoryItem.gradient,
      shadowColor: categoryItem.shadowColor,
      imagePath: categoryItem.imagePath,
      title: categoryItem.title,
      onTapFunction: () => onTap(categoryType),
    );
  }

  factory CategoryItem.fromModel(
      Category category, Function(Categories) onTap) {
    return CategoryItem(
      labelBackgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          category.gradientColor1.fromHexToColor(),
          category.gradientColor2.fromHexToColor()
        ],
      ),
      shadowColor: category.shadowColor.fromHexToColor(),
      imagePath: _getIconPath(category.type),
      title: category.title,
      onTapFunction: () => onTap(category.type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildGradientLabel(),
            const SizedBox(
              height: labelBottomMargin,
            ),
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .caption
                    .copyWith(fontSize: FontSizes.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientLabel() {
    return Container(
      alignment: Alignment.center,
      height: categoryLabelSize,
      width: categoryLabelSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: Radiuses.big_1x,
              offset: Dimens.defaultBlurOffset),
        ],
        gradient: labelBackgroundGradient,
      ),
      child: Center(
        child: SvgPicture.asset(
          imagePath,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  static String _getIconPath(Categories type) {
    switch (type) {
      case Categories.apparel:
        return Assets.apparelIcon;
      case Categories.beauty:
        return Assets.beautyIcon;
      case Categories.electronics:
        return Assets.electronicsIcon;
      case Categories.furniture:
        return Assets.furnitureIcon;
      case Categories.home:
        return Assets.homeIcon;
      case Categories.shoes:
        return Assets.shoesIcon;
      case Categories.stationary:
      default:
        return Assets.stationaryIcon;
    }
  }
}
