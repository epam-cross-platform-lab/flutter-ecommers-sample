import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final String title;
  final List<MenuItemModel> itemList;
  final EdgeInsets margin;
  final double itemHeight;

  const MenuList({
    this.title,
    this.itemList,
    this.margin = const EdgeInsets.all(0.0),
    this.itemHeight = 48.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (title != null && title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: Insets.x2_5),
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        Container(
          margin: margin,
          decoration: BoxDecoration(
            color: BrandingColors.background,
            borderRadius: BorderRadius.circular(Radiuses.normal),
            boxShadow: const [
              BoxShadow(
                blurRadius: Radiuses.big_1x,
                offset: Dimens.defaultBlurOffset,
                color: BrandingColors.blur,
              )
            ],
          ),
          child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemList.length,
              padding: const EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                final itemModel = itemList[index];

                return MenuItem(
                  title: itemModel.title,
                  subTitle: itemModel.subTitle,
                  svgAssetIconPath: itemModel.svgAssetIconPath,
                  height: itemHeight,
                );
              },
              separatorBuilder: (context, index) {
                final menuItem = itemList[index];

                return Divider(
                  color: BrandingColors.secondary.withOpacity(0.1),
                  height: 1.0,
                  indent: menuItem.svgAssetIconPath == null ? 15.0 : 57.0,
                  endIndent: 17.0,
                  thickness: 1,
                );
              }),
        ),
      ],
    );
  }
}
