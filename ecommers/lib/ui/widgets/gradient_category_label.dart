import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientCategoryLabel extends StatelessWidget {

  final _imageCategoryPadding = EdgeInsets.all(14);
  final _boxShadowOffset = Offset(0, 8);

  final Gradient backgroundGradient;
  final Color shadowColor;
  final String imagePath;

 GradientCategoryLabel({this.backgroundGradient, this.shadowColor, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimens.categoryLabelSize,
      width: Dimens.categoryLabelSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
              color: shadowColor,
               blurRadius: Dimens.categoryLabelShadowBlurRadius,            
               offset: _boxShadowOffset)
        ],
        gradient: backgroundGradient,
      ),
      child: Padding(
          padding: _imageCategoryPadding,
          child: SvgPicture.asset(imagePath)
          ),
    );
  }
}
