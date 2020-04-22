import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodProviderModel extends ProviderModelBase {
  List<PaymentMethodModel> _paymentMethods = <PaymentMethodModel>[];
  PaymentMethod _selectedItem;

  List<PaymentMethodModel> get paymentMethods => _paymentMethods;
  PaymentMethod get selectedItem => _selectedItem;
  set selectedItem(PaymentMethod item) {
    _selectedItem = item;
    notifyListeners();
  }

  PaymentMethodProviderModel(BuildContext context) : super(context) {
    _initialize();
  }

  Future _initialize() async {
     _paymentMethods =
     await paymentMethodService.getPaymentMethods() ?? <PaymentMethodModel>[];
  }

  Future addPaymentMethod() async {
    final CreditCard testCard = CreditCard(
      number: '4000002760003184',
      expMonth: 12,
      expYear: 21,
    );
    final paymentMethod =
        await paymentMethodService.createPyamentMethod(testCard);
    if (paymentMethod != null) _paymentMethods.add(paymentMethod);
    notifyListeners();
  }

  Future<PaymentMethodModel> removePaymentMethod(int index) async {
    final removedItem = _paymentMethods.removeAt(index);
     await paymentMethodService.removePaymentMethod(removedItem);

    return removedItem;
  }
}
