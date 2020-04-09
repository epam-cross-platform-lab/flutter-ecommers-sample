import 'package:flutter/material.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/widgets/index.dart';

abstract class ProductItemBase extends StatelessWidget {
  @protected
  static const double padding = 10.0;

  final String assetImagePath;
  final String title;
  final double cost;
  final Size productSize;
  final int id;

  const ProductItemBase(
      {@required this.assetImagePath,
      @required this.title,
      @required this.cost,
      @required this.productSize,
      this.id});

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      padding: const EdgeInsets.all(10.0),
      height: productSize.height,
      width: productSize.width,
      child: GestureDetector(
        onTap: () => {
          navigationService.navigateTo(Pages.product),
        },
        child: buildProductItem(context),
      ),
    );
  }

  Widget buildProductItem(BuildContext context);
}
