import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/widgets/right_menu_bar/subtitle_factory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';

import 'models/right_menu_item_model.dart';

@immutable
class RightMenuItem extends StatelessWidget {
  final RightMenuItemModel itemModel;

  const RightMenuItem({this.itemModel});
  static const double _height = 50.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              itemModel.title,
              style: textTheme.subtitle1,
            ),
          ),
          RightMenuSubTitle(model: itemModel),
          const SizedBox(width: Insets.x2_5),
          SvgPicture.asset(Assets.menuArrowIcon),
        ],
      ),
    );
  }
}
