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
      viewportFraction: 0.91,
      items: List.generate(
        3,
        (index) {
          return SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Insets.x2),
              child: ImageCard(
                buttonText: 'CLICK ME',
                description: 'item: $index SOOOOme looooong description',
                imageAsset: GIRL_IMAGE,
                onButtonPressed: () {},
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLatestGridView(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: _calculateLatestGridViewPadding(context),
        vertical: Insets.x2_5,
      ),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _latestGridViewAxisCount,
          mainAxisSpacing: _latestGridViewAxisSpacing,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Center(
              child: ProductItemNormal(
                assetImagePath: BACKPACK_IMAGE,
                cost: 15.0,
                title: 'top back pack',
                rate: 3.9,
              ),
            );
          },
          childCount: 30,
        ),
      ),
    );
  }

  double _calculateLatestGridViewPadding(BuildContext context) {
    var pageWidth = MediaQuery.of(context).size.width;

    var gridItemHorizontalPadding = (pageWidth -
            2 * Dimens.pagePadding -
            _latestGridViewAxisCount * productItemNormalSize.width) /
        (2 * _latestGridViewAxisCount);

    return Dimens.pagePadding - gridItemHorizontalPadding;
  }
}
