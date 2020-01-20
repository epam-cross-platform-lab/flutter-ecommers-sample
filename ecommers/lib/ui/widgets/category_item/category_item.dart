import 'package:ecommers/common/categories.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryItem extends StatelessWidget {
  final Gradient labelBackgroundGradient;
  final Color shadowColor;
  final String imagePath;
  final String title;

  CategoryItem(
      {@required this.labelBackgroundGradient,
      @required this.shadowColor,
      @required this.imagePath,
      @required this.title});

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
      width: Dimens.categoryItemWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildGradientLabel(),
          SizedBox(
            height: labelBottomMargin,
          ),
          Text(
            title,
            style: Styles.categoryItemTitle,
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
        boxShadow: [
          BoxShadow(
              color: shadowColor,
              blurRadius: Dimens.categoryLabelShadowBlurRadius,
              offset: boxShadowOffset),
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
