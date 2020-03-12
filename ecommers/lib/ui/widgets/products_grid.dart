import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final int Function(ProductModel, ProductModel) compareFunction;
  const ProductsGrid({this.compareFunction, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.lightGreen,
      Colors.lightBlueAccent,
      Colors.yellow,
      Colors.indigo,
      Colors.pinkAccent
    ];

    final products = Provider.of<List<ProductModel>>(context);
    final sortedProducts = List<ProductModel>.from(products ?? []);

    if (compareFunction != null && sortedProducts.isNotEmpty) {
      sortedProducts.sort(compareFunction);
    }

    return Container(
      color: BrandingColors.pageBackground,
      child: sortedProducts.isEmpty
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
                children: sortedProducts
                    .map((product) => ProductItemWide(
                          assetImagePath: product.imageUri,
                          title: product.title,
                          cost: product.cost,
                          rate: product.rate,
                          color: colors[product.id % colors.length],
                        ))
                    .toList(),
              ),
            ),
    );
  }
}
