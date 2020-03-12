import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/products_grid.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductsGridPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final Categories type;

  ProductsGridPage({this.type, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final tabStyle = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(fontWeight: FontWeight.w400);

    return BasePage<ProductsGridProviderModel>(
      createProvider: (BuildContext context) =>
          ProductsGridProviderModel(context, type),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: RightMenuWidget(),
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
                onPressed: () => _scaffoldKey.currentState.openEndDrawer(),
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
              ProductsGrid(compareFunction: ProductComparator.byCostDescendant),
            ],
          ),
        ),
      ),
    );
  }
}
