import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodProviderModel extends ProviderModelBase {
  List<PaymentMethodModel> _paymentMethods = <PaymentMethodModel>[];
  PaymentMethodModel _selectedPaymentMethod;
  CreditCard creditCard = CreditCard();

  List<PaymentMethodModel> get paymentMethods => _paymentMethods;
  PaymentMethodModel get selectedPaymentMethod => _selectedPaymentMethod;


  PaymentMethodProviderModel(BuildContext context) : super(context) {
    _initialize();
  }
    void selectItem(PaymentMethodModel paymentMethod) {

    if(_selectedPaymentMethod == null){
      _selectedPaymentMethod = paymentMethod..isPaymentMethodSelected = true;
      paymentMethodService.editPaymentMethod(_selectedPaymentMethod);
      notifyListeners();
    }

    if(paymentMethod.id==_selectedPaymentMethod.id) return;

    paymentMethod.isPaymentMethodSelected = true;
    _selectedPaymentMethod.isPaymentMethodSelected = false;
    notifyListeners();

    paymentMethodService.editPaymentMethod(_selectedPaymentMethod);
    paymentMethodService.editPaymentMethod(paymentMethod);
    
    _selectedPaymentMethod = paymentMethod;
  }
  Future _initialize() async {
     _paymentMethods =
     await paymentMethodService.getPaymentMethods() ?? <PaymentMethodModel>[];
     _selectedPaymentMethod = _paymentMethods.firstWhere((m) => m.isPaymentMethodSelected, orElse:() => null);
     notifyListeners();
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
      notifyListeners();
    return removedItem;
  }
}
