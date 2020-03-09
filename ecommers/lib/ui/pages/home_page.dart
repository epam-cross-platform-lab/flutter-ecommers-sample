import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/core/models/index.dart';
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
    final colors = [
      ProductColorModel(
        isSelected: false,
        color: 0xFFF48FB1,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFB74D,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFF64B5F6,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFFFFF,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFE0E0E0,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFF000000,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFF81C784,
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFF176,
      ),
    ];
    final sizes = [
      ProductSizeModel(
        isSelected: false,
        size: '4.5',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '5.0',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '5.5',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '6.0',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '6.5',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '7.0',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '7.5',
      ),
      ProductSizeModel(
        isSelected: false,
        size: '8.0',
      ),
    ];

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
            return ProductItemNormal(
              productModel: ProductItemModel(
                  assetImagePath: _getDressAssetPath(index),
                  cost: 15.0,
                  title: 'best dress ever',
                  colors: colors,
                  sizes: sizes,
                  ),
              rate: 3.9,
            );
          },
          childCount: 30,
        ),
      ),
    );
  }

  String _getDressAssetPath(int index) {
    final modulo = index % 6;

    if (modulo == 0) return Assets.dressCottonImage;
    if (modulo == 1) return Assets.dressFloral2Image;
    if (modulo == 2) return Assets.dressFloralImage;
    if (modulo == 3) return Assets.dressPattern2Image;
    if (modulo == 4) return Assets.dressPatternImage;
    if (modulo == 5) {
      return Assets.dressCotton2Image;
    } else {
      return Assets.greenBackpackImage;
    }
  }
}
