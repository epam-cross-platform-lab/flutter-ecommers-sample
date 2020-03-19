import 'package:meta/meta.dart';

class ProductColorModel {
  bool isSelected;
  final int color;
  final List<String> assetsImagePaths;

  ProductColorModel({
    @required this.isSelected,
    @required this.color,
    @required this.assetsImagePaths,
  });
}
