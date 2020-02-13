import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_normal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const int _latestGridViewAxisCount = 3;
  static const double _latestGridViewAxisSpacing = 12.0;
  static const imageCardSize = Size(325.0, 184.0);
  static const productItemNormalSize = Size(101.0, 135.0);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CategoriesCompactWidget(),
              const SizedBox(height: Dimens.pagePadding),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Insets.x6),
                child: Text(
                  I18n.of(context).latetstTitle,
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              SizedBox(height: 10.0),
              _buildLatestCarousel(context),
            ],
          ),
        ),
        _buildLatestGridView(context),
      ],
    );
  }

  Widget _buildLatestCarousel(BuildContext context) {
    return CarouselSlider(
      viewportFraction: 0.92,
      items: List.generate(
        6,
        (index) {
          return SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.x2),
              child: ImageCard(
                buttonText: 'SEE MORE',
                description: 'For all your summer clothing needs',
                imageAsset: getCarouselImage(index),
                onButtonPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

  String getCarouselImage(int index) {
    var modulo = index % 3;

    if (modulo == 0)
      return GIRL_IMAGE;
    else if (modulo == 1)
      return GIRL2_IMAGE;
    else
      return GIRL3_IMAGE;
  }

  Widget _buildLatestGridView(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.pagePadding,
        vertical: Insets.x2_5,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: ProductItemNormal.sizeN.height,
          mainAxisSpacing: _latestGridViewAxisSpacing,
          crossAxisSpacing: _latestGridViewAxisSpacing,
          childAspectRatio:
              ProductItemNormal.sizeN.width / ProductItemNormal.sizeN.height,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return ProductItemNormal(
              assetImagePath: _getDressAssetPath(index),
              cost: 15.0,
              title: 'best dress ever',
              rate: 3.9,
            );
          },
          childCount: 30,
        ),
      ),
    );
  }

  String _getDressAssetPath(int index) {
    var modulo = index % 6;

    if (modulo == 0) return DRESS_COTTON_IMAGE;
    if (modulo == 1) return DRESS_FLORAL2_IMAGE;
    if (modulo == 2) return DRESS_FLORAL_IMAGE;
    if (modulo == 3) return DRESS_PATTERN2_IMAGE;
    if (modulo == 4) return DRESS_PATTERN_IMAGE;
    if (modulo == 5) return DRESS_COTTON2_IMAGE;
  }
}
