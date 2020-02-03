import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RateWidget extends StatelessWidget {
  final Size size;
  final double rate;

  const RateWidget({
    @required this.rate,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    var containerSize = size ?? Dimens.rateContainerSize;

    return Container(
      height: containerSize.height,
      width: containerSize.width,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: BrandingColors.primary,
        borderRadius: BorderRadius.circular(Dimens.rateContainerBorderRadius),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SvgPicture.asset(RATE_STAR_ICON),
            Text(
              rate.toString(),
              style: Theme.of(context).textTheme.overline,
            )
          ],
        ),
      ),
    );
  }
}
