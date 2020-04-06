import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/models/data_models/index.dart';
import '../../core/provider_models/index.dart';
import '../../ui/decorations/dimens/index.dart';
import '../../ui/pages/index.dart';
import '../../ui/widgets/category_item/categories_compact_view.dart';
import '../../ui/widgets/index.dart';
import '../../ui/widgets/product_item/index.dart';

class HomePage extends StatelessWidget {
  static const double _latestGridViewAxisSpacing = 12.0;
  static const imageCardSize = Size(325.0, 184.0);
  static const productItemNormalSize = Size(101.0, 135.0);

  @override
  Widget build(BuildContext context) {
    return BasePage(
      createProvider: (context) => HomeProviderModel(context),
      child: Consumer<HomeProviderModel>(
        builder: (context, provider, child) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    CategoriesCompactView(provider.categoryList),
                    const SizedBox(height: Dimens.pagePadding),
                    NotesCarousel(notes: provider.notesLatest),
                  ],
                ),
              ),
              _buildLatestGridView(context, provider.productsLatest),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLatestGridView(BuildContext context, List<Product> products) {
    if (products == null) return const SliverToBoxAdapter();

    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: Dimens.pagePadding,
        vertical: Insets.x2_5,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ProductItemNormal.size.height,
          mainAxisSpacing: _latestGridViewAxisSpacing,
          crossAxisSpacing: _latestGridViewAxisSpacing,
          childAspectRatio:
              ProductItemNormal.size.width / ProductItemNormal.size.height,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final product = products[index];

            return ProductItemNormal.fromModel(product);
          },
          childCount: products.length,
        ),
      ),
    );
  }
}
