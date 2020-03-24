import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_normal.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
              const SizedBox(height: 10.0),
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
              padding: const EdgeInsets.symmetric(horizontal: Insets.x2),
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
    final modulo = index % 3;

    if (modulo == 0) {
      return Assets.girlImage;
    } else if (modulo == 1) {
      return Assets.girl2Image;
    } else {
      return Assets.girl3Image;
    }
  }

  Widget _buildLatestGridView(BuildContext context) {
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
            return Hero(
              tag: _getDressAssetPath(index),
              child: ProductItemNormal(
                assetImagePath: _getDressAssetPath(index),
                cost: 15.0,
                title: 'best dress ever',
              ),
            );
          },
          childCount: 9,
        ),
      ),
    );
  }

  String _getDressAssetPath(int index) {
    final modulo = index % 9;

    if (modulo == 0) return Assets.dressCottonImage;
    if (modulo == 1) return Assets.dressFloral2Image;
    if (modulo == 2) return Assets.dressFloralImage;
    if (modulo == 3) return Assets.dressPattern2Image;
    if (modulo == 4) return Assets.dressPatternImage;
    if (modulo == 5) return Assets.blackShoes;
    if (modulo == 6) return Assets.goldShoes;
    if (modulo == 7) return Assets.redShoes;
    if (modulo == 8) {
      return Assets.dressCotton2Image;
    } else {
      return Assets.greenBackpackImage;
    }
  }
}
