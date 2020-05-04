import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_wrapper.g.dart';

@JsonSerializable()
class PaymentMethodWrapper {
  final String id;
  final int userId;
  final PaymentMethodModel paymentMethodModel;

  PaymentMethodWrapper({
    this.id,
    this.userId,
    this.paymentMethodModel,
  });

  factory PaymentMethodWrapper.fromPaymentMethod(
      PaymentMethodModel paymentMethod) {
    return PaymentMethodWrapper(
      id: paymentMethod.id,
      userId: membershipService.id,
      paymentMethodModel: paymentMethod,
    );
  }

  static const fromJson = _$PaymentMethodWrapperFromJson;

  Map<String, dynamic> toJson() => _$PaymentMethodWrapperToJson(this);
}