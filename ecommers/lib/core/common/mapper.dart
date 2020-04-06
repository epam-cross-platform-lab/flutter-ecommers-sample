import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class Mapper {
  static OrderModel convertProductToOrder(ProductItemModel product) {
    return OrderModel(
      id: 4,
      imagePath: Assets.blackShoes,
      title: product.title,
      cost: product.cost,
      description: 'Medium, Green 3',
      count: 1,
    ); //todo change mapping after refactoring productPage
  }
}
