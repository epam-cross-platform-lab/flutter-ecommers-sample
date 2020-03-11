import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ProductPageBottomView extends StatelessWidget {
  final Size buttonSize;

  const ProductPageBottomView({@required this.buttonSize});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Divider(
          height: Insets.x8,
          color: BrandingColors.secondary.withOpacity(0.6),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: buttonSize.height,
              width: buttonSize.width,
              child: SecondaryButtonWidget(
                text: I18n.of(context).shareThis,
                onPressedFunction: () => {},
                assetIcon: Assets.shareArrowIcon,
              ),
            ),
            SizedBox(
              height: buttonSize.height,
              width: buttonSize.width,
              child: PrimaryButtonWidget(
                text: I18n.of(context).addToCart,
                onPressedFunction: () => {},
              ),
            ),
          ],
        ),
      ],
    );
  }
}
