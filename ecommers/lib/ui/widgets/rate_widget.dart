import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RateWidget extends StatelessWidget {
  final Size size;
  final double rate;

  static const rateContainerSize = Size(33.0, 16.0); 

  const RateWidget({
    @required this.rate,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final containerSize = size ?? rateContainerSize;

    return Container(
      height: containerSize.height,
      width: containerSize.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: BrandingColors.primary,
        borderRadius: BorderRadius.circular(Radiuses.big_1x),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(Assets.starIcon),
            Text(
              Formatter.getRate(rate),
              style: textTheme.overline,
            )
          ],
        ),
      ),
    );
  }
}
