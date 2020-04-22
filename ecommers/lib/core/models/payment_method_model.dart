import 'package:json_annotation/json_annotation.dart';
import 'package:stripe_payment/stripe_payment.dart';

part 'payment_method_model.g.dart';

@JsonSerializable()
class PaymentMethodModel {
  final String id;
  bool isPaymentMethodSelected;
  final String cardCountry;
  final int cardExpMonth;
  final int cardExpYear;
  final String cardNumberLast4;
  final String cardBrand;

  PaymentMethodModel({
    this.id,
    this.cardCountry,
    this.cardExpMonth,
    this.cardExpYear,
    this.cardNumberLast4,
    this.cardBrand,
    this.isPaymentMethodSelected = false,
  });

  factory PaymentMethodModel.fromStripePaymentMethod(PaymentMethod paymentMethod) {
    return PaymentMethodModel(
      id: paymentMethod.id,
      isPaymentMethodSelected: false,
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
