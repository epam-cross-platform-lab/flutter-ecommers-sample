import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/provider_models/home_provider_model.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';

class ProductLatestGrid extends StatefulWidget {
  final ScrollController controller;

  const ProductLatestGrid({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _ProductLatestGridState createState() => _ProductLatestGridState();
}

class _ProductLatestGridState extends State<ProductLatestGrid> {
  ItemsLoadingNotifier _loadingProvider;
  
  @override
  void didUpdateWidget (ProductLatestGrid oldWidget) {
    super.didUpdateWidget(oldWidget);

    oldWidget.controller.removeListener(scrollListener);
    widget.controller.addListener(scrollListener);
  }

  void scrollListener() {
    _loadingProvider ??= Provider.of<HomeProviderModel>(context, listen: false);

    if (!_loadingProvider.isItemsLoading &&
        _loadingProvider.hasMoreItems &&
        widget.controller.position.maxScrollExtent - widget.controller.offset <=
            scrollOffsetDelta) {
      _loadingProvider.loadMoreProducts();
    }
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final products =
        Provider.of<HomeProviderModel>(context, listen: false).productsLatest;

    if (products == null) return const SliverToBoxAdapter();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.pagePadding,
        vertical: Insets.x2_5,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ProductItemNormal.size.height,
          mainAxisSpacing: Insets.x3,
          crossAxisSpacing: Insets.x3,
          childAspectRatio:
              ProductItemNormal.size.width / ProductItemNormal.size.height,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];

            return ProductItemNormal(product: product);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
