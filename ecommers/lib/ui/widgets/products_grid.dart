import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/mixins/index.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/index.dart';

class ProductsGrid extends StatefulWidget {
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
  _ProductsGridState createState() => _ProductsGridState();
}

class _ProductsGridState extends State<ProductsGrid> {
  final ScrollController _controller =
      ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  ItemsLoadingNotifier _loadingProvider;

  @override
  void initState() {
    _controller.addListener(scrollListener);

    super.initState();
  }

  void scrollListener() {
    if (_loadingProvider == null) return;

    if (!_loadingProvider.isItemsLoading &&
        _loadingProvider.hasMoreItems &&
        _controller.position.maxScrollExtent - _controller.offset <=
            scrollOffsetDelta) {
      _loadingProvider.loadMoreProducts();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProxyProvider<SearchQueryProviderModel,
        ProductsGridProviderModel>(
      create: (_) => ProductsGridProviderModel(
        categoryType: widget.categoryType,
        sortType: widget.sortType,
        subCategory: widget.subCategory,
      ),
      update: (_, searchProvider, productsProvider) {
        return productsProvider..updateProducts(searchProvider.searchQuery);
      },
      child: BusyPage<ProductsGridProviderModel>(
        child: Consumer<ProductsGridProviderModel>(
          builder: (_, provider, child) {
            _loadingProvider ??= provider;

            return CustomScrollView(
              controller: _controller,
              slivers: [
                _buildProductsGrid(provider.products),
                child,
              ],
            );
          },
          child: const ItemsLoader<ProductsGridProviderModel>(),
        ),
      ),
    );
  }

  Widget _buildProductsGrid(List<Product> products) {
    if (products == null || products.isEmpty) return const SliverToBoxAdapter();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Insets.x5,
        vertical: Insets.x4,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ProductItemWide.size.height,
          mainAxisSpacing: Insets.x3,
          crossAxisSpacing: Insets.x3,
          childAspectRatio:
              ProductItemWide.size.width / ProductItemWide.size.height,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];

            return ProductItemWide(product: product);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
