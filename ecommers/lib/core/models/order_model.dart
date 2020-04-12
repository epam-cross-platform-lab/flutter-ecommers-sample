import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:json_annotation/json_annotation.dart';
import 'data_models/index.dart';
part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;
  final String title;
  final String description;
  final String imagePath;
  final double cost;
  int count;

  OrderModel({
    this.id,
    this.description,
    this.cost,
    this.imagePath,
    this.title,
    this.count,
  });

  static const fromJson = _$OrderModelFromJson;

  factory OrderModel.fromProduct(ProductItemModel product) {
    return OrderModel(
      id: 4,
      imagePath: Assets.blackShoes,
      title: product.title,
      cost: product.cost,
      description: 'Medium, Green 3',
      count: 1,
    ); //todo change mapping after refactoring productPage
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
