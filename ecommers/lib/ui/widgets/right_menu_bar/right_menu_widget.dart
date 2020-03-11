import 'dart:ui';
import 'package:ecommers/ui/widgets/right_menu_bar/index.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';

class RightMenuWidget extends StatelessWidget {
  final List<RightMenuItemModel> filterMenuList = [
    RightMenuSubTitleModel(
      title: 'View',
      subTitle: 'Thumbnails',
    ),
    RightMenuSubTitleModel(
      title: 'Category',
      subTitle: 'Men\'s Apparel',
    ),
    RightMenuSubTitleModel(
      title: 'Condition',
      subTitle: 'Brand New',
    ),
    RightMenuSubTitleModel(
      title: 'Material',
      subTitle: 'Cotton',
    ),
    RightMenuColorsModel(
      title: 'Colour',
      colors: ['#77CBFF', '#FF77E5', '#C5DC1B'],
    ),
    RightMenuSubTitleModel(
      title: 'Brand',
      subTitle: 'All Brands',
    ),
    RightMenuSubTitleModel(
      title: 'Size',
      subTitle: 'Large',
    ),
    RigthMenuPriceModel(
      title: 'Price Range',
      minPrice: '0',
      maxPrice: '30',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      margin: EdgeInsets.zero,
      child: Drawer(
        elevation: 0.0,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5.0,
            sigmaY: 5.0,
          ),
          child: Container(
            color: BrandingColors.background,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        I18n.of(context).refineResults,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: FontSizes.small_3x,
                              color: Colors.transparent.withOpacity(0.3),
                            ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => {}, //TODO: handle click
                        child: Text(
                          I18n.of(context).clear,
                          style: Theme.of(context).textTheme.headline5.copyWith(
                              fontSize: FontSizes.small_3x,
                              color: BrandingColors.primary),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Insets.x3_5),
                  RightMenuItemsList(
                    itemList: filterMenuList,
                  ),
                  const SizedBox(height: Insets.x2_5),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: 47.0,
                        width: 230.0,
                        child: PrimaryButtonWidget(
                          text: I18n.of(context).applyFilters,
                          onPressedFunction: () => {}, //TODO:  handle click
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
