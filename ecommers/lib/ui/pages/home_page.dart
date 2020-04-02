import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/home_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_normal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                    CategoriesCompactWidget(),
                    const SizedBox(height: Dimens.pagePadding),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: Insets.x6),
                      child: Text(
                        I18n.of(context).latetstTitle,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _buildLatestCarousel(context, provider.notesLatest),
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

  Widget _buildLatestCarousel(BuildContext context, List<Note> notes) {
    if (notes == null) return const SizedBox();

    return CarouselSlider(
      viewportFraction: 0.92,
      items: notes
          .map(
            (e) => SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.x2),
                child: ImageCard(
                  buttonText: e.commandText,
                  description: e.title,
                  imageUrl: e.imageUrl,
                  onButtonPressed: () {}, //TODO: handle Click
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  String getCarouselImage(int index) {
    final modulo = index % 3;

    if (modulo == 0) {
      return Assets.girlImage;
    } else if (modulo == 1) {
      return Assets.girl2Image;
    } else {
      return Assets.girl3Image;
    }
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
