import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart'; 
import 'package:ecommers/ui/widgets/category_item/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem extends StatelessWidget {
  final Gradient labelBackgroundGradient;
  final Color shadowColor;
  final Color backgroundColor;
  final String imagePath;
  final String title;

  CategoryItem({
    @required this.shadowColor,
    @required this.imagePath,
    @required this.title,
    this.labelBackgroundGradient,
    this.backgroundColor,
  });

  factory CategoryItem.fromType(Categories categoryType) {
    var categoryItem = categoryItems[categoryType];

    return CategoryItem(
      labelBackgroundGradient: categoryItem.gradient,
      shadowColor: categoryItem.shadowColor,
      imagePath: categoryItem.imagePath,
      title: categoryItem.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Dimens.categoryItemSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildGradientLabel(),
          SizedBox(
            height: labelBottomMargin,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .caption
                .copyWith(fontSize: FontSizes.normal),
          ),
        ],
      ),
    );
  }

  _buildGradientLabel() {
    return Container(
      alignment: Alignment.center,
      height: Dimens.categoryLabelSize,
      width: Dimens.categoryLabelSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: Dimens.defaultBlurRadius,
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
}
