import 'package:ecommers/core/models/index.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel implements ItemBase {
  @override
  final String id;
  final String cardCountry;
  final int cardExpMonth;
  final int cardExpYear;
  final String cardNumberLast4;
  final String cardBrand;
  bool isSelected;

  PaymentMethodModel({
    this.id,
    this.cardCountry,
    this.cardExpMonth,
    this.cardExpYear,
    this.cardNumberLast4,
    this.cardBrand,
    this.isSelected = false,
  });

  factory PaymentMethodModel.fromStripePaymentMethod(PaymentMethod paymentMethod) {
    return PaymentMethodModel(
      id: paymentMethod.id,
      isSelected: false,
      cardBrand: paymentMethod.card.brand,
      cardCountry: paymentMethod.card.country,
      cardExpMonth: paymentMethod.card.expMonth,
      cardExpYear: paymentMethod.card.expYear,
      cardNumberLast4: paymentMethod.card.last4,
    );
  }

  static const fromJson = _$PaymentMethodModelFromJson;

  Map<String, dynamic> toJson() => _$PaymentMethodModelToJson(this);
}
