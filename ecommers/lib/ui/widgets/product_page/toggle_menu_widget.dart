import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:ecommers/core/models/index.dart';

import 'index.dart';

class ToggleMenuWidget extends StatelessWidget {
  final ProductItemModel productModel;

  const ToggleMenuWidget({
    @required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    final tabStyle = Theme.of(context).textTheme.subtitle1;
    const _tabBarPreferredSize = Size(0, 50);
    const _tabBarPadding = EdgeInsets.only(left: 50, right: 50);
    final localization = I18n.of(context);
    const _tabsCount = 3;
    const _tabBarIndicatorHeight = 35.0;

    return BackgroundedSafeArea(
      child: DefaultTabController(
        length: _tabsCount,
        child: Scaffold(
          backgroundColor: BrandingColors.pageBackground,
          appBar: PreferredSize(
            preferredSize: _tabBarPreferredSize,
            child: Center(
              child: Padding(
                padding: _tabBarPadding,
                child: TabBar(
                  indicator: BubbleTabIndicator(
                    indicatorHeight: _tabBarIndicatorHeight,
                    indicatorColor: BrandingColors.background,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  labelStyle: tabStyle,
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
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              ProductTabWidget(
                colors: productModel.colors,
                sizes: productModel.sizes,
              ),
              const DetailsTabWidget(),
              const ReviewsTabWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
