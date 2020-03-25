import 'package:ecommers/core/models/index.dart';

class ProductComparator {
  static int byRate(ProductModel firstProduct, ProductModel secondProduct) {
    return secondProduct.rate.compareTo(firstProduct.rate);
  }

  static int byCost(ProductModel firstProduct, ProductModel secondProduct) {
    return firstProduct.cost.compareTo(secondProduct.cost);
  }

  static int byCostDescendant(
      ProductModel firstProduct, ProductModel secondProduct) {
    return -byCost(firstProduct, secondProduct);
  }
}
