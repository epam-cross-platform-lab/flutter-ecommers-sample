import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIcon extends StatelessWidget {
  static const size = Size(18.0, 18.0);
  static const _defaultIcon = ARROW_ICON;

  final String imagePath;
  CircleIcon({this.imagePath = _defaultIcon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: BrandingColors.backgroundIcon,
      ),
      child: SvgPicture.asset(
        imagePath,
        fit: BoxFit.scaleDown,
        color: BrandingColors.secondary,
      ),
    );
  }
}
