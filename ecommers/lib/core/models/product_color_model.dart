import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:meta/meta.dart';

class ProductColorModel {
  bool isSelected;
  final int color;
  final List<CarouselImage> images;

  ProductColorModel({
    @required this.isSelected,
    @required this.color,
    @required this.images,
  });
}
