import 'package:ecommers/core/provider_models/index.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodProviderModel extends ProviderModelBase {
  List<PaymentMethod> _paymentMethods = <PaymentMethod>[];

  List<PaymentMethod> get paymentMethods => _paymentMethods;

  PaymentMethodProviderModel(BuildContext context) : super(context) {
    _initialize();
  }

  void _initialize() {
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_O4MySLvZlQMSIVMEJPCQjbIv00CnR4Bawc',
      merchantId: 'Test',
      androidPayMode: 'test',
    ));

    _paymentMethods = <PaymentMethod>[]; //todo from bd
  }

  Future addPaymentMethod() async {
    await StripePayment.paymentRequestWithCardForm(
      CardFormPaymentRequest(),
    ).then((PaymentMethod paymentMethod) async {
      _paymentMethods.add(paymentMethod);
      notifyListeners();
    }).catchError((){});
  }

  PaymentMethod removePaymentMethod(int index) => _paymentMethods.removeAt(index);
}
