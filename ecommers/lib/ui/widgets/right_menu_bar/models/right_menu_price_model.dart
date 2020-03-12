import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';

class RigthMenuPriceModel extends RightMenuItemModel {
  final String minPrice;
  final String maxPrice;

  RigthMenuPriceModel({String title, this.minPrice, this.maxPrice})
      : super(title: title);
}
