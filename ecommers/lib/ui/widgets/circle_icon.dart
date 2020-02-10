import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CircleIcon extends StatelessWidget {
  static const actionForCountLabelSize = Size(18.0, 18.0);

  final String imagePath;
  CircleIcon({@required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: actionForCountLabelSize.width,
      height: actionForCountLabelSize.height,
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
