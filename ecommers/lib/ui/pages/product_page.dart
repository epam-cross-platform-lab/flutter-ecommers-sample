import 'package:ecommers/core/models/data_models/index.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart' hide BackButton;

import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/branding_colors.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/icon_with_badge.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/product_page/index.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';

class ProductPage extends StatelessWidget {
  final Product productModel;

  const ProductPage({@required this.productModel, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final valueNotifier = ValueNotifier<int>(0);
    final pageController = PageController(initialPage: 0, keepPage: false);

    return ChangeNotifierProvider(
      create: (_) => ProductPageProviderModel(
        productModel,
        context: context,
      ),
      child: Consumer<ProductPageProviderModel>(
        builder: (context, ProductPageProviderModel model, child) {
          return Scaffold(
            backgroundColor: BrandingColors.pageBackground,
            appBar: AppBar(
              leading: const BackButton(),
              title: Header(
                title: productModel?.title,
                cost: productModel?.price,
                rate: productModel?.rate,
              ),
              actions: <Widget>[
                Selector<CartProvider, int>(
                  builder: (context, data, child) {
                    return IconButton(
                      icon: IconWithBadge(
                        badgeValue: cartProvider.orderCount,
                        badgeTextStyle: Theme.of(context).textTheme.overline,
                        icon: const Icon(
                          Icons.shopping_cart,
                          color: BrandingColors.primaryText,
                        ),
                      ),
                      onPressed: () =>
                          navigationService.navigateTo(Pages.checkout),
                    );
                  },
                  selector: (buildContext, cartProvider) =>
                      cartProvider.orderCount,
                )
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: Insets.x2_5),
                Expanded(
                  child: ListView(
                    children: [
                      CarouselWidget(
                        images: model.images,
                        currentPageNotifier: valueNotifier,
                        currentPageController: pageController,
                        height: 250,
                      ),
                      SizedBox(
                        height: 300,
                        child: ProductPageTabsView(
                          productModel: productModel,
                          imagesHasChanged: (assets) => {
                            model.updateImages(assets),
                            valueNotifier.value = 0,
                            pageController.jumpToPage(0),
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: Insets.x5,
                    right: Insets.x5,
                    bottom: Insets.x5,
                  ),
                  child: ProductPageBottomView(
                      buttonSize: const Size(165.0, 46.0),
                      addToCartFunction: () {
                        cartProvider.add(OrderModel.fromProduct(productModel));
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
