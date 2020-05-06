import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ProductPageBottomView extends StatelessWidget {
  final Function() addToCartFunction;
  final Function() sharedFunction;

  const ProductPageBottomView(
      {@required this.addToCartFunction, this.sharedFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SecondaryButtonWidget(
                text: localization.shareThis,
                onPressedFunction: sharedFunction,
                assetIcon: Assets.shareArrowIcon,
              ),
            ),
            const SizedBox(width: Insets.x7),
            Flexible(
              child: PrimaryButtonWidget(
                text: localization.addToCart,
                onPressedFunction: addToCartFunction,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
