import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

import '../../../extensions/index.dart';

class CategoryItem extends StatelessWidget {
  final Category model;
  final bool isSelected;
  final Function() onTapFunction;

  static const size = Size(82.0, 148.0);
  static const categoryLabelSize = 65.0;

  const CategoryItem({
    @required this.model,
    this.isSelected = false,
    this.onTapFunction,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle unselectedTextStyle =
        textTheme.caption.copyWith(fontSize: FontSizes.normal);

    final TextStyle selectedTextStyle =
        unselectedTextStyle.copyWith(color: BrandingColors.primary);

    return GestureDetector(
      onTap: onTapFunction,
      child: Container(
        width: size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildGradientLabel(),
            const SizedBox(height: Insets.x1_5),
            Flexible(
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: isSelected ? selectedTextStyle : unselectedTextStyle,
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
        boxShadow: [
          BoxShadow(
            color: model.shadowColor.fromHexToColor(),
            blurRadius: Radiuses.big_1x,
            offset: Dimens.defaultBlurOffset,
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            model.gradientColor1.fromHexToColor(),
            model.gradientColor2.fromHexToColor(),
          ],
        ),
      ),
      child: Center(
        child: SvgPicture.asset(
          _getIconPath(model.type),
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
        return Assets.stationaryIcon;
      case Categories.seeAll:
      default:
        return Assets.arrowRightIcon;
    }
  }
}
