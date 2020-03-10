import 'package:badges/badges.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatelessWidget {
  final String title;
  final double cost;
  final double rate;

  const Header({
    @required this.cost,
    @required this.title,
    @required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: Insets.x0_5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Formatter.getCost(cost),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: Insets.x1_5),
            Badge(
              badgeContent: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.rateStarIcon,
                    fit: BoxFit.scaleDown,
                  ),
                  const SizedBox(width: Insets.x0_5),
                  Text(
                    rate.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: BrandingColors.secondaryText),
                  ),
                ],
              ),
              badgeColor: BrandingColors.primary,
              animationType: BadgeAnimationType.scale,
              shape: BadgeShape.square,
              borderRadius: Radiuses.small_2x,
              padding: const EdgeInsets.symmetric(
                vertical: Insets.x1_5,
                horizontal: Insets.x0_5,
              ),
            )
          ],
        ),
      ],
    );
  }
}
