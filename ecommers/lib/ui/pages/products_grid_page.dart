import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/products_grid.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ProductsGridPage extends StatelessWidget {
  final Categories type;

  const ProductsGridPage({this.type, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final tabStyle = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(fontWeight: FontWeight.w400);

    return ChangeNotifierProxyProvider<ProductsGridProviderModel,
        BusyProviderModel>(
      create: (_) => BusyProviderModel(),
      update: (_, productsGridProvider, busyProvider) =>
          busyProvider..isBusy = productsGridProvider.isBusy,
      child: BusyPage(
        child: FutureProvider(
          create: (context) =>
              Provider.of<ProductsGridProviderModel>(context).getData(type),
          initialData: null,
          child: DefaultTabController(
            length: 4,
            child: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: SvgPicture.asset(
                    Assets.backIcon,
                    color: BrandingColors.primary,
                    height: Insets.x4_5,
                  ),
                  onPressed: () => navigationService.goBack(),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: SvgPicture.asset(
                      Assets.filterIcon,
                    ),
                    onPressed: () => {},
                  )
                ],
                title: const SearchTextField(),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(text: localization.productsBestMatchTab),
                    Tab(text: localization.productsTopRatedTab),
                    Tab(text: localization.productsLowToHighPriceTab),
                    Tab(text: localization.productsLowToHighPriceTab),
                  ],
                  indicatorColor: Colors.transparent,
                  labelStyle: tabStyle,
                  labelColor: BrandingColors.primary,
                  unselectedLabelColor: tabStyle.color,
                  isScrollable: true,
                ),
              ),
              body: const TabBarView(
                children: [
                  ProductsGrid(),
                  ProductsGrid(compareFunction: ProductComparator.byRate),
                  ProductsGrid(compareFunction: ProductComparator.byCost),
                  ProductsGrid(
                      compareFunction: ProductComparator.byCostDescendant),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
