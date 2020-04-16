import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import 'index.dart';

class ProductPageTabsView extends StatefulWidget {
  final Product productModel;
  final Function(List<CarouselImage>) imagesHasChanged;

  const ProductPageTabsView({
    @required this.productModel,
    this.imagesHasChanged,
  });

  @override
  _ProductPageTabsViewState createState() => _ProductPageTabsViewState();
}

class _ProductPageTabsViewState extends State<ProductPageTabsView> {
  String skuId;
  List<ProductSizeModel> sizes;
  List<ProductColorModel> colors;

  @override
  void initState() {
    final models = widget.productModel?.models;

    if (models?.isNotEmpty == true) {
      skuId = models[0]?.skuId?.toString();
      colors = _getColors(models);
      sizes = _getSizes(models);

      if (colors?.isNotEmpty == true) {
        colors[0].isSelected = true;
      }

      if (sizes?.isNotEmpty == true) {
        sizes[0].isSelected = true;
      }
    }

    super.initState();
  }

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
                  colors: colors,
                  sizes: sizes,
                  colorHasChanged: (images) => {
                    if (widget.imagesHasChanged != null)
                      {
                        widget.imagesHasChanged(images),
                      }
                  },
                  skuIdHasChanged: (skuIdModel) => _updateSkuId(skuIdModel),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.x4_5,
                  vertical: Insets.x4,
                ),
                child: DetailsTab(
                  productDetailModel: widget.productModel?.details,
                  skuId: skuId,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Insets.x4_5,
                  vertical: Insets.x4,
                ),
                child: ReviewsTab(
                    productReviewsModel: widget.productModel?.reviews),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _updateSkuId(ProductSkuIdModel skuIdModel) {
    setState(() => {
          skuId = widget.productModel?.models
              ?.firstWhere((product) => product.size == skuIdModel.size)
              ?.skuId
              ?.toString(),
        });
  }

  List<ProductColorModel> _getColors(List<ProductModel> models) {
    return models
        ?.map((product) => ProductColorModel(
            color: 0xFFBBDEFB,
            images: product.imageUrls
                ?.map((url) =>
                    CarouselImage(tag: widget.productModel.id, path: url))
                ?.toList()))
        ?.toList();
  }

  List<ProductSizeModel> _getSizes(List<ProductModel> models) {
    return models
        ?.map((product) => ProductSizeModel(size: product.size))
        ?.toList();
  }
}
