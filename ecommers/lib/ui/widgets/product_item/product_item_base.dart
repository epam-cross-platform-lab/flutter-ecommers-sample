import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

abstract class ProductItemBase extends StatelessWidget {
  @protected
  static const double padding = 10.0;

  final ProductItemModel productModel;
  final Size productSize;

  const ProductItemBase({
    @required this.productModel,
    @required this.productSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: productSize.height,
      width: productSize.width,
      decoration: BoxDecoration(
        color: BrandingColors.background,
        borderRadius: BorderRadius.circular(Radiuses.normal),
        boxShadow: const [
          BoxShadow(
            blurRadius: Radiuses.big_1x,
            color: BrandingColors.blur,
            offset: Dimens.defaultBlurOffset,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => {
          navigationService.navigateTo(Pages.product, arguments: productModel),
        },
        child: buildProductItem(context),
      ),
    );
  }

  Widget buildProductItem(BuildContext context);
}
