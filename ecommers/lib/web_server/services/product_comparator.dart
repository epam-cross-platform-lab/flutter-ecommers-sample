import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/models/sort_type.dart';

class ProductComparator {
  static int Function(Product, Product) bySortType(SortType sortType) {
    switch (sortType) {
      case SortType.rate:
        return byRate;
      case SortType.cost:
        return byCost;
      case SortType.costDesc:
      default:
        return byCostDescendant;
    }
  }

  static int byRate(Product firstProduct, Product secondProduct) {
    return secondProduct.rate.compareTo(firstProduct.rate);
  }

  static int byCost(Product firstProduct, Product secondProduct) {
    return firstProduct.price.compareTo(secondProduct.price);
  }

  static int byCostDescendant(Product firstProduct, Product secondProduct) {
    return -byCost(firstProduct, secondProduct);
  }
}
