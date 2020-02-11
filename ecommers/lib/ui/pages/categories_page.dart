import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/widgets/category_item/category_item.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/material.dart';

const List<MenuItemModel> _topMenuList = [
  MenuItemModel(
    title: 'T-shirt',
  ),
  MenuItemModel(
    title: 'Shirts',
  ),
  MenuItemModel(
    title: 'Pants & Jeans',
  ),
  MenuItemModel(
    title: 'Socks & Ties',
  ),
  MenuItemModel(
    title: 'Underwear',
  ),
  MenuItemModel(
    title: 'Jackets',
  ),
  MenuItemModel(
    title: 'Coats',
  ),
  MenuItemModel(
    title: 'Sweaters',
  ),
];

const List<MenuItemModel> _bottomMenuList = [
  MenuItemModel(
    title: 'Officewear',
  ),
  MenuItemModel(
    title: 'Blouce & T-Shirts',
  ),
  MenuItemModel(
    title: 'Pants & Jeans',
  ),
  MenuItemModel(
    title: 'Dresses',
  ),
  MenuItemModel(
    title: 'Lingerie',
  ),
  MenuItemModel(
    title: 'Jackets',
  ),
  MenuItemModel(
    title: 'Coats',
  ),
  MenuItemModel(
    title: 'Sweaters',
  ),
];

class CategoriesPage extends StatelessWidget {
  const CategoriesPage();

  @override
  Widget build(BuildContext context) {
    return CloseablePage(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Insets.x5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(context).allCategories,
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: Insets.x6),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildCategories(),
                  SizedBox(width: Insets.x6),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        MenuList(
                          title: 'MEN\'S APPAREL',
                          itemHeight: 44.0,
                          itemList: _topMenuList,
                        ),
                        Divider(
                          height: 52.0,
                          thickness: 1.0,
                          color: BrandingColors.secondary.withOpacity(0.1),
                        ),
                        MenuList(
                          title: 'WOMEN\'S APPAREL',
                          itemHeight: 44.0,
                          itemList: _bottomMenuList,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      width: CategoryItem.size.width,
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: Categories.values.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: Insets.x8,
          height: Insets.x8,
        ),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return CategoryItem.fromType(Categories.values[index]);
        },
      ),
    );
  }
}
