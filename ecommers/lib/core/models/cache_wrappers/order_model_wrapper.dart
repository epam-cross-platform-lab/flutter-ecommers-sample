import 'package:ecommers/core/models/cache_wrappers/wrapper.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model_wrapper.g.dart';

@JsonSerializable()
class OrderModelWrapper implements Wrapper{
  @override
  final int id;
  final int userId;
  final OrderModel order;

  OrderModelWrapper({
    this.id,
    this.userId,
    this.order,
  });

  factory OrderModelWrapper.fromOrderModel(
      OrderModel order) {
    return OrderModelWrapper(
      id: order.product.id,
      userId: membershipService.id,
      order: order,
    );
  }
  static const fromJson = _$OrderModelWrapperFromJson;

  Map<String, dynamic> toJson() => _$OrderModelWrapperToJson(this);
}