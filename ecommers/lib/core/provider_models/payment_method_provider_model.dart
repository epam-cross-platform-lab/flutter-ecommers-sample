import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodProviderModel extends ChangeNotifier {
  List<PaymentMethodModel> _paymentMethods = <PaymentMethodModel>[];
  PaymentMethodModel _selectedPaymentMethod;
  CreditCard creditCard = CreditCard();
  String expDate = '';

  PaymentMethodProviderModel() {
    _initialize();
  }

  List<PaymentMethodModel> get paymentMethods => _paymentMethods;
  PaymentMethodModel get selectedPaymentMethod => _selectedPaymentMethod;

  void selectPaymentMethod(PaymentMethodModel paymentMethod) {
    if (_selectedPaymentMethod == null) {
      _selectedPaymentMethod = paymentMethod..isSelected = true;
      paymentMethodService.editPaymentMethod(_selectedPaymentMethod);
      notifyListeners();
    }

    if (paymentMethod.id == _selectedPaymentMethod.id) return;

    paymentMethod.isSelected = true;
    _selectedPaymentMethod.isSelected = false;
    notifyListeners();

    paymentMethodService.editPaymentMethod(_selectedPaymentMethod);
    paymentMethodService.editPaymentMethod(paymentMethod);

    _selectedPaymentMethod = paymentMethod;
  }

  Future addPaymentMethod() async {
    if (!_trySetExpDate()) return;
    if (!_isValidCard()) return;

    final paymentMethod =
        await paymentMethodService.createPyamentMethod(creditCard);

    if (paymentMethod != null) {
      _paymentMethods.add(paymentMethod);
      notifyListeners();
    }

    navigationService.navigateWithReplacementTo(Pages.paymentMethod);
  }

  Future<PaymentMethodModel> removePaymentMethod(int index) async {
    final removedItem = _paymentMethods.removeAt(index);
    if (removedItem.id == selectedPaymentMethod.id) {
      _selectedPaymentMethod = null;
    }

    await paymentMethodService.removePaymentMethod(removedItem);
    return removedItem;
  }

  bool _trySetExpDate() {
    if (expDate[0] == '0') expDate = expDate.substring(1);
    final monthAndYear = expDate.split('/');

    if (monthAndYear.length != 2) return false;

    final expMonth = int.parse(monthAndYear[0]);
    final expYear = int.parse(monthAndYear[1]);

    if (expMonth > 12 || expMonth < 1 || expYear < 20 || expYear > 99) {
      return false;
    }
    
    creditCard.expMonth = expMonth;
    creditCard.expYear = expYear;
    return true;
  }

  bool _isValidCard() {
    if (creditCard.number?.length != 16) return false;
    if (creditCard.cvc?.length != 3) return false;

    return true;
  }

  Future _initialize() async {
    _paymentMethods = await paymentMethodService.getPaymentMethods() ??
        <PaymentMethodModel>[];
    _selectedPaymentMethod =
        _paymentMethods.firstWhere((m) => m.isSelected, orElse: () => null);
    notifyListeners();
  }
}
