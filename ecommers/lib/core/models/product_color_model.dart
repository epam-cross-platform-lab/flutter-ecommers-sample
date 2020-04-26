import 'package:ecommers/ui/widgets/right_menu_bar/models/index.dart';
import 'package:meta/meta.dart';

class ProductColorModel {
  bool isSelected;
  final int color;
  final String title;
  final List<CarouselImage> images;

  ProductColorModel({
    @required this.color,
    @required this.images,
    this.isSelected = false,
    this.title,
  });
}
