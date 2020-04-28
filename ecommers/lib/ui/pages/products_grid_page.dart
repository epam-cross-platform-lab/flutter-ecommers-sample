import 'package:ecommers/shared/i18n.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/products_grid.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:ecommers/ui/widgets/search/index.dart';
import 'package:ecommers/core/provider_models/index.dart';

class ProductsGridPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final Categories categoryType;
  final String subCategory;

  ProductsGridPage({
    this.categoryType,
    this.subCategory,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    final tabStyle = Theme.of(context)
        .textTheme
        .headline5
        .copyWith(fontWeight: FontWeight.w400);

    return ChangeNotifierProvider<SearchQueryProviderModel>.value(
      value: SearchQueryProviderModel(),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          key: _scaffoldKey,
          endDrawer: RightMenuWidget(),
          appBar: AppBar(
            leading: const BackButton(),
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
                Tab(text: localization.productsHighToLowPriceTab),
              ],
              indicatorColor: Colors.transparent,
              labelStyle: tabStyle,
              labelColor: BrandingColors.primary,
              unselectedLabelColor: tabStyle.color,
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              ProductsGrid(
                categoryType: categoryType,
                subCategory: subCategory,
              ),
              ProductsGrid(
                categoryType: categoryType,
                subCategory: subCategory,
                sortType: SortType.rate,
              ),
              ProductsGrid(
                categoryType: categoryType,
                subCategory: subCategory,
                sortType: SortType.cost,
              ),
              ProductsGrid(
                categoryType: categoryType,
                subCategory: subCategory,
                sortType: SortType.costDesc,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
