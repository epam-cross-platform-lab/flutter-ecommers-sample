import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';
import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final List<MenuItemModel> itemList;
  final EdgeInsets margin;

  MenuList({this.itemList, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: Palette.menuListBackground,
        borderRadius: BorderRadius.circular(Dimens.menuListBorderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: Dimens.defaultBlurRadius,
            offset: Dimens.defaultBlurOffset,
            color: Palette.menuListBlur,
          )
        ],
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          var itemModel = itemList[index];

          return MenuItem(
            title: itemModel.title,
            subTitle: itemModel.subTitle,
            svgAssetIconPath: itemModel.svgAssetIconPath,
          );
        },
        separatorBuilder: (context, index) => Divider(
          color: Palette.divider,
          height: 1.0,
          indent: 57.0,
          endIndent: 17.0,
          thickness: 1,
        ),
      ),
    );
  }
}