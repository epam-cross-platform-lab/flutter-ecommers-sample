import 'package:ecommers/core/models/index.dart';

class ProductItemModel {
  final String assetImagePath;
  final String title;
  final double rate;
  final double cost;
  final List<ProductColorModel> colors;
  final List<ProductSizeModel> sizes;

  ProductItemModel({
    this.assetImagePath,
    this.cost,
    this.title,
    this.rate,
    this.colors,
    this.sizes,
  });
}