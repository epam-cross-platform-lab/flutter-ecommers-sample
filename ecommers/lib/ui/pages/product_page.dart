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
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({@required this.productModel, Key key}) : super(key: key);

  final Product productModel;

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ValueNotifier<int> valueNotifier;
  PageController pageController;
  List<CarouselImage> images = [];

  @override
  void initState() {
    if (widget.productModel?.models?.isNotEmpty == true) {
      images = widget.productModel.models[0].imageUrls
          ?.map((url) => CarouselImage(tag: widget.productModel.id, path: url))
          ?.toList();
    }

    valueNotifier = ValueNotifier<int>(0);
    pageController = PageController(initialPage: 0, keepPage: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
        title: Header(
          title: widget.productModel?.title,
          cost: widget.productModel?.price,
          rate: widget.productModel?.rate,
        ),
        actions: <Widget>[
          Selector<CartProvider, int>(
            builder: (context, data, child) {
              return IconButton(
                icon: IconWithBadge(
                  badgeValue: cartProvider.orderCount,
                  badgeTextStyle: Theme.of(context).textTheme.overline,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: BrandingColors.primaryText,
                  ),
                ),
                onPressed: () => navigationService.navigateTo(Pages.checkout),
              );
            },
            selector: (buildContext, cartProvider) => cartProvider.orderCount,
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
                  images: images,
                  currentPageNotifier: valueNotifier,
                  currentPageController: pageController,
                  height: 250,
                ),
                SizedBox(
                  height: 300,
                  child: ProductPageTabsView(
                    productModel: widget.productModel,
                    imagesHasChanged: (assets) => {
                      setState(() => {
                            valueNotifier.value = 0,
                            pageController.jumpToPage(0),
                            images = assets,
                          }),
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
                  cartProvider.add(OrderModel.fromProduct(widget.productModel));
                }),
          ),
        ],
      ),
    );
  }
}
