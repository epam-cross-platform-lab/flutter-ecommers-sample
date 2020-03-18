import 'package:ecommers/core/models/index.dart';

class ProductItemModel {
  final List<String> assetsImagePaths;
  final String title;
  final double rate;
  final ProductDetailsModel productDetailsModel;
  final double cost;
  final List<ProductColorModel> colors;
  final List<ProductSizeModel> sizes;
  final List<ProductReviewsModel> reviews;

  ProductItemModel({
    this.assetsImagePaths,
    this.productDetailsModel,
    this.cost,
    this.title,
    this.rate,
    this.colors,
    this.sizes,
    this.reviews
  });
}
