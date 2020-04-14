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
  const ProductPage({Key key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductItemModel productModel = createProductModel();
  ValueNotifier<int> valueNotifier;
  PageController pageController;
  List<CarouselImage> images = [];

  @override
  void initState() {
    valueNotifier = ValueNotifier<int>(0);
    pageController = PageController(initialPage: 0, keepPage: false);
    images = productModel.colors[0].images;
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
          title: productModel.title,
          cost: productModel.cost,
          rate: productModel.rate,
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
                    productModel: productModel,
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
                  cartProvider
                      .add(OrderModel.fromProduct(productModel));
                }),
          ),
        ],
      ),
    );
  }

  static ProductItemModel createProductModel() {
    final colors = [
      ProductColorModel(
        isSelected: true,
        color: 0xFF000000,
        images: [
          CarouselImage(
            path: Assets.blackShoes,
            id: 0,
          ),
          CarouselImage(
            path: Assets.blackShoes,
            id: 0,
          ),
          CarouselImage(
            path: Assets.blackShoes,
            id: 0,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFF9C4,
        images: [
          CarouselImage(
            path: Assets.goldShoes,
            id: 1,
          ),
          CarouselImage(
            path: Assets.goldShoes,
            id: 1,
          ),
          CarouselImage(
            path: Assets.goldShoes,
            id: 1,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFCDD2,
        images: [
          CarouselImage(
            path: Assets.pinkShoes,
            id: 2,
          ),
          CarouselImage(
            path: Assets.pinkShoes,
            id: 2,
          ),
          CarouselImage(
            path: Assets.pinkShoes,
            id: 2,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFE57373,
        images: [
          CarouselImage(
            path: Assets.redShoes,
            id: 3,
          ),
          CarouselImage(
            path: Assets.redShoes,
            id: 3,
          ),
          CarouselImage(
            path: Assets.redShoes,
            id: 3,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFF06292,
        images: [
          CarouselImage(
            path: Assets.roseRedShoes,
            id: 4,
          ),
          CarouselImage(
            path: Assets.roseRedShoes,
            id: 4,
          ),
          CarouselImage(
            path: Assets.roseRedShoes,
            id: 4,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFE0E0E0,
        images: [
          CarouselImage(
            path: Assets.silverShoes,
            id: 5,
          ),
          CarouselImage(
            path: Assets.silverShoes,
            id: 5,
          ),
          CarouselImage(
            path: Assets.silverShoes,
            id: 5,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFFFFF,
        images: [
          CarouselImage(
            path: Assets.whiteShoes,
            id: 6,
          ),
          CarouselImage(
            path: Assets.whiteShoes,
            id: 6,
          ),
          CarouselImage(
            path: Assets.whiteShoes,
            id: 6,
          ),
        ],
      ),
      ProductColorModel(
        isSelected: false,
        color: 0xFFFFF176,
        images: [
          CarouselImage(
            path: Assets.yellowShoes,
            id: 7,
          ),
        ],
      ),
    ];
    final sizes = [
      ProductSizeModel(
        isSelected: true,
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
    final reviews = [
      ProductReviewsModel(
        countOfStars: 4,
        name: 'Jane Doe',
        nameAbbreviation: 'JD',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
        date: DateTime.now(),
        profileImageColor: 0xFFB2EBF2,
        profileImageTextColor: 0xFF80DEEA,
        screenshotsPathes: [
          Assets.blackShoes,
          Assets.goldShoes,
          Assets.pinkShoes,
          Assets.redShoes,
          Assets.roseRedShoes,
        ],
      ),
      ProductReviewsModel(
        countOfStars: 3,
        name: 'Sam Smith',
        nameAbbreviation: 'SS',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
        date: DateTime.now(),
        profileImageColor: 0xFFA5D6A7,
        profileImageTextColor: 0xFF81C784,
        screenshotsPathes: [
          Assets.blackShoes,
          Assets.goldShoes,
          Assets.pinkShoes,
          Assets.redShoes,
          Assets.roseRedShoes,
        ],
      ),
      ProductReviewsModel(
        countOfStars: 4,
        name: 'Jane Doe',
        nameAbbreviation: 'JD',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
        date: DateTime.now(),
        profileImageColor: 0xFFB2EBF2,
        profileImageTextColor: 0xFF80DEEA,
        screenshotsPathes: [
          Assets.blackShoes,
          Assets.goldShoes,
          Assets.pinkShoes,
          Assets.redShoes,
          Assets.roseRedShoes,
        ],
      ),
      ProductReviewsModel(
        countOfStars: 3,
        name: 'Sam Smith',
        nameAbbreviation: 'SS',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed',
        date: DateTime.now(),
        profileImageColor: 0xFFA5D6A7,
        profileImageTextColor: 0xFF81C784,
        screenshotsPathes: [
          Assets.blackShoes,
          Assets.goldShoes,
          Assets.pinkShoes,
          Assets.redShoes,
          Assets.roseRedShoes,
        ],
      ),
    ];

    return ProductItemModel(
      title: 'best dress ever',
      cost: 15.0,
      rate: 3.9,
      productDetailsModel: ProductDetailsModel(
        brand: "Lily's Ankle Boots",
        sku: '0590458902809',
        condition: 'Brand New, With Box',
        material: 'Faux Sued, Velvet',
        category: 'Women Shoes',
        fitting: 'True To Size',
      ),
      colors: colors,
      sizes: sizes,
      reviews: reviews,
    );
  }
}
