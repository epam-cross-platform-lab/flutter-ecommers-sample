import 'package:json_annotation/json_annotation.dart';
import 'data_models/index.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final Product product;
  final String characteristics;
  int count;

  OrderModel({
    this.product,
    this.characteristics,
    this.count = 1,
  });

  static const fromJson = _$OrderModelFromJson;

  factory OrderModel.fromProduct({Product product, String size, String color}) {
    return OrderModel(
      product: product,
      characteristics: '$size, $color',
      count: 1,
    );
  }

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}
