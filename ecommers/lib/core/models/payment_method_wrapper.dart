import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:json_annotation/json_annotation.dart';

part 'payment_method_wrapper.g.dart';

@JsonSerializable()
class PaymentMethodWrapper {
  final int userId;
  final PaymentMethodModel paymentMethodModel;
  final String id;

  PaymentMethodWrapper(
   { this.id, 
    this.userId,
    this.paymentMethodModel,
  });

  factory PaymentMethodWrapper.fromPaymentMethod(PaymentMethodModel paymentMethod) {
    return PaymentMethodWrapper(
      userId: membershipService.id,
      paymentMethodModel: paymentMethod,
      id: paymentMethod.id,
    );
  }

  static const fromJson = _$PaymentMethodWrapperFromJson;

  Map<String, dynamic> toJson() => _$PaymentMethodWrapperToJson(this);
}
