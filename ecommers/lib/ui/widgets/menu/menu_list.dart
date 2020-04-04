import 'package:flutter/material.dart';

import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/menu/index.dart';

class MenuList extends StatelessWidget {
  static const itemHeight = 48.0;

  final List<MenuItemModel> itemList;
  final EdgeInsets margin;

  const MenuList({
    this.itemList,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SurfaceContainer(
          margin: margin,
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
              return Divider(
                color: BrandingColors.secondary.withOpacity(0.1),
                height: 1.0,
                indent: 57.0,
                endIndent: 17.0,
                thickness: 1,
              );
            },
          ),
        ),
      ],
    );
  }
}
