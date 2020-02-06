import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/category_item/categories_compact_widget.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_item/product_item_normal.dart';
import 'package:flutter/material.dart';

import '../decorations/index.dart';

class HomePage extends StatelessWidget {
  static const int _latestGridViewAxisCount = 3;
  static const double _latestGridViewAxisSpacing = 12.0;
  static const double _latestCarouselViewportFraction = 0.9;
  static const imageCardSize = Size(325.0, 184.0);
  static const productItemNormalSize = Size(101.0, 135.0);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 9.0),
        _buildLatestCarousel(),
        const SizedBox(height: 11.0),
        Expanded(
          child: _buildLatestGridView(context),
        ),
      ],
    );
  }

  Widget _buildLatestCarousel() {
    return CarouselSlider(
      height: imageCardSize.height,
      viewportFraction: _latestCarouselViewportFraction,
      items: List.generate(
        3,
        (index) {
          return ImageCard(
            buttonText: 'Click me',
            description: 'item: $index SOOOOme looooong description',
            imageAsset: GIRL_IMAGE,
            onButtonPressed: () {},
          );
        },
      ),
    );
  }

  Widget _buildLatestGridView(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: _latestGridViewAxisCount,
        mainAxisSpacing: _latestGridViewAxisSpacing,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: _calculateLatestGridViewPadding(context)),
      itemCount: 550,
      itemBuilder: (context, index) {
        return Center(
          child: ProductItemNormal(
            assetImagePath: BACKPACK_IMAGE,
            cost: 15.0,
            title: 'top back pack',
            rate: 3.9,
          ),
        );
      },
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
