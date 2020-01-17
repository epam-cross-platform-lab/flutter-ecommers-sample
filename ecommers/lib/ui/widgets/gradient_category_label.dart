import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GradientCategoryLabel extends StatelessWidget {
  final _boxShadowOffset = Offset(0, 8);

  final Gradient backgroundGradient;
  final Color shadowColor;
  final String imagePath;
  final EdgeInsets imageCategoryPadding;

  GradientCategoryLabel(
      {@required this.backgroundGradient,
      @required this.shadowColor,
      @required this.imagePath,
      @required this.imageCategoryPadding});

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
              offset: _boxShadowOffset),
        ],
        gradient: backgroundGradient,
      ),
      
      child:Center( child: Padding(
        padding: imageCategoryPadding,
        child: SvgPicture.asset(
          imagePath,),
      ),
    ),);
  }
}
