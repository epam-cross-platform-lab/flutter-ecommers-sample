import 'dart:io';

import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatefulWidget {
  final int Function(ProductModel, ProductModel) compareFunction;

  const ProductsGrid({this.compareFunction, Key key}) : super(key: key);

  @override
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  ProductsGridProviderModel _provider;
  List<ProductModel> _products;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_provider == null) {
      _provider = Provider.of<ProductsGridProviderModel>(context);

      Future.microtask(() => _provider.getData())
          .then((value) => _products = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    const colors = [
      Colors.lightGreen,
      Colors.lightBlueAccent,
      Colors.yellow,
      Colors.indigo,
      Colors.pinkAccent
    ];

    final sortedProducts = List<ProductModel>.from(_products ?? []);

    if (widget.compareFunction != null && sortedProducts.isNotEmpty) {
      sortedProducts.sort(widget.compareFunction);
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
                          id: product.id,
                        ))
                    .toList(),
              ),
            ),
    );
  }
}
