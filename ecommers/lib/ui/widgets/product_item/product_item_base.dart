import 'package:ecommers/core/models/data_models/index.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/widgets/index.dart';

abstract class ProductItemBase extends StatelessWidget {
  @protected
  static const double padding = 10.0;

  final Product product;
  final Size productSize;

  const ProductItemBase({
    @required this.product,
    @required this.productSize,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      padding: const EdgeInsets.all(10.0),
      height: productSize.height,
      width: productSize.width,
      child: GestureDetector(
        onTap: () => {
          navigationService.navigateTo(Pages.product, arguments: product),
        },
        child: buildProductItem(context),
      ),
    );
  }

  Widget buildProductItem(BuildContext context);
}
