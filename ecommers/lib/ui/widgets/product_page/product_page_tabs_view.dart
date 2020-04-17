import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/product_page_tabs_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class ProductPageTabsView extends StatelessWidget {
  final Product productModel;
  final Function(List<CarouselImage>) imagesHasChanged;

  const ProductPageTabsView({
    @required this.productModel,
    this.imagesHasChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabBarStyle = Theme.of(context).textTheme.subtitle1;
    final localization = I18n.of(context);

    return ChangeNotifierProvider(
      create: (_) => ProductPageTabsProviderModel(
        productModel,
        context: context,
      ),
      child: Consumer<ProductPageTabsProviderModel>(
        builder: (context, ProductPageTabsProviderModel model, child) {
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
                        colors: model.colors,
                        sizes: model.sizes,
                        colorHasChanged: (images) => {
                          if (imagesHasChanged != null)
                            {
                              imagesHasChanged(images),
                            }
                        },
                        skuIdHasChanged: (skuIdModel) =>
                            model.updateSkuId(skuIdModel),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.x4_5,
                        vertical: Insets.x4,
                      ),
                      child: DetailsTab(
                        productDetailModel: productModel?.details,
                        skuId: model.skuId,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Insets.x4_5,
                        vertical: Insets.x4,
                      ),
                      child: ReviewsTab(
                          productReviewsModel: productModel?.reviews),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
