import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class SurfaceContainer extends StatelessWidget {
  final double borderRadius;
  final Color backgroundColor;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double height;
  final double width;
  final Widget child;

  const SurfaceContainer({
    Key key,
    this.borderRadius = Radiuses.normal,
    this.backgroundColor = BrandingColors.background,
    this.margin = const EdgeInsets.all(0.0),
    this.padding = const EdgeInsets.all(0.0),
    this.height,
    this.width,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      alignment: Alignment.center,
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor,
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Dimens.defaultBlurOffset,
            blurRadius: Radiuses.big_1x,
            color: BrandingColors.blur,
          )
        ],
      ),
      child: child,
    );
  }
}
