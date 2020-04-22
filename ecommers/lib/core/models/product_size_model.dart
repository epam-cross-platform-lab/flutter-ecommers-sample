import 'package:meta/meta.dart';

class ProductSizeModel {
  bool isSelected;
  final String size;

  ProductSizeModel({
    @required this.size,
    this.isSelected = false,
  });
}