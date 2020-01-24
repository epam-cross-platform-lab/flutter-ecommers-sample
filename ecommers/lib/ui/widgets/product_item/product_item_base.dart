import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

abstract class ProductItemBase extends StatelessWidget {
  @protected
  static const double padding = 10.0;

  final String assetImagePath;
  final String title;
  final double cost;
  final double rate;
  final Size size;

  ProductItemBase({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    @required this.size,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(padding),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Palette.productItemBackground,
        borderRadius: BorderRadius.circular(Dimens.productItemBorderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: Dimens.defaultBlurRadius,
            color: Palette.productItemBlur,
            offset: Dimens.defaultBlurOffset,
          ),
        ],
      ),
      child: buildProductItem(),
    );
  }

  Widget buildProductItem();
}
