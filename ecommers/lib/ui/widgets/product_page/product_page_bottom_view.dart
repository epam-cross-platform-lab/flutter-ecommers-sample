import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:flutter/material.dart';

class ProductPageBottomView extends StatelessWidget {
  final Size buttonSize;
  final Function() addToCartFunction;

  const ProductPageBottomView({@required this.buttonSize, this.addToCartFunction});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: buttonSize.height,
              width: buttonSize.width,
              child: SecondaryButtonWidget(
                text: localization.shareThis,
                onPressedFunction: () => {},
                assetIcon: Assets.shareArrowIcon,
              ),
            ),
            SizedBox(
              height: buttonSize.height,
              width: buttonSize.width,
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
