import 'package:ecommers/core/common/index.dart';
import 'package:flutter/material.dart';

import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final Categories categoryType;
  final String subCategory;
  final SortType sortType;

  const ProductsGrid({
    this.sortType,
    this.categoryType,
    this.subCategory,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.lightGreen,
      Colors.lightBlueAccent,
      Colors.yellow,
      Colors.indigo,
      Colors.pinkAccent
    ];

    return BasePage<ProductsGridProviderModel>(
      createProvider: (_) => ProductsGridProviderModel(
        context,
        categoryType,
        subCategory,
        sortType,
      ),
      child: Consumer<ProductsGridProviderModel>(
        builder: (_, provider, __) {
          final products = provider.products;

          return Container(
            color: BrandingColors.pageBackground,
            child: products == null || products.isEmpty
                ? const SizedBox()
                : Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Insets.x5,
                      vertical: Insets.x4,
                    ),
                    child: GridView.extent(
                      maxCrossAxisExtent: ProductItemWide.size.height,
                      mainAxisSpacing: Insets.x3,
                      crossAxisSpacing: Insets.x3,
                      childAspectRatio: ProductItemNormal.size.width /
                          ProductItemNormal.size.height,
                      children: products
                          .map((product) => ProductItemWide(
                                assetImagePath: product.images[0],
                                title: product.title,
                                cost: product.price,
                                rate: product.rate,
                                color: colors[product.id % colors.length],
                                id: product.id,
                              ))
                          .toList(),
                    ),
                  ),
          );
        },
      ),
    );
  }
}
