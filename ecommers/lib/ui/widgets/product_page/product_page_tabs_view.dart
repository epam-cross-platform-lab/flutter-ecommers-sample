import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:ecommers/core/models/index.dart';

import 'index.dart';

class ProductPageTabsView extends StatelessWidget {
  final ProductItemModel productModel;
  final Function(List<String>) assetsHasChanged;
  const ProductPageTabsView({
    @required this.productModel,
    this.assetsHasChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabBarStyle = Theme.of(context).textTheme.subtitle1;
    final localization = I18n.of(context);

    return BackgroundedSafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: BrandingColors.pageBackground,
          appBar: PreferredSize(
            preferredSize: const Size(0, 50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: TabBar(
                indicator: const BubbleTabIndicator(
                  indicatorHeight: Insets.x8_5,
                  indicatorColor: BrandingColors.background,
                  tabBarIndicatorSize: TabBarIndicatorSize.tab,
                ),
                labelStyle: tabBarStyle,
                labelColor: BrandingColors.primary,
                unselectedLabelColor: BrandingColors.primaryText,
                isScrollable: false,
                tabs: [
                  Tab(text: localization.product),
                  Tab(text: localization.details),
                  Tab(text: localization.reviews),
                ],
              ),
            ),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.x4_5,
                  vertical: Insets.x5,
                ),
                child: ProductTab(
                  colors: productModel.colors,
                  sizes: productModel.sizes,
                  colorHasChanged: (assets) => {
                    assetsHasChanged(assets),
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.x4_5,
                  vertical: Insets.x4,
                ),
                child: DetailsTab(
                    productDetailModel: productModel.productDetailsModel),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.x4_5,
                  vertical: Insets.x4,
                ),
                child: ReviewsTab(productReviewsModel: productModel.reviews),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
