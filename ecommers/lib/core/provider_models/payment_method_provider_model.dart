import 'package:ecommers/core/common/validator/index.dart';
import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodProviderModel extends ChangeNotifier {
  bool isNumberValid, isNameValid, isDateValid, isCvcValid;
  List<PaymentMethodModel> _paymentMethods = <PaymentMethodModel>[];
  List<PaymentMethodModel> selectedPaymentMethod = <PaymentMethodModel>[];
  PaymentMethodModel paymentMethod = PaymentMethodModel();
  CreditCard creditCard = CreditCard();
  String expDate = '';

  List<PaymentMethodModel> get paymentMethods => _paymentMethods;

  Future initialize() async {
    _paymentMethods = await paymentMethodService.getPaymentMethods() ??
        <PaymentMethodModel>[];
    selectedPaymentMethod =
        await paymentMethodService.getSelectedPaymentMethod();
    notifyListeners();
  }

  Future selectPaymentMethod(PaymentMethodModel paymentMethod) async {
    if (selectedPaymentMethod.isEmpty) {
      await paymentMethodService.addSelectedPaymentMethod(paymentMethod);
      selectedPaymentMethod.add(paymentMethod);
      notifyListeners();
    }

    if (selectedPaymentMethod[0].id == paymentMethod.id) return;

    if (selectedPaymentMethod[0].id != paymentMethod.id) {
      await paymentMethodService.updateSelectedPaymentMethod(paymentMethod);
      selectedPaymentMethod[0] = paymentMethod;
      notifyListeners();
    }
  }

  Future addPaymentMethod() async {
    if (!_isPaymentMethodValid()) {
      notifyListeners();
      return;
    }

    creditCard.number = creditCard.number.replaceAll('-', '');
    final paymentMethod =
        await paymentMethodService.createPyamentMethod(creditCard);

    if (paymentMethod != null) {
      _paymentMethods.add(paymentMethod);
      notifyListeners();
    }
    navigationService.goBack();
  }

  Future<PaymentMethodModel> removePaymentMethod(int index) async {
    final removedItem = _paymentMethods.removeAt(index);
    if (selectedPaymentMethod.isNotEmpty &&
        removedItem.id == selectedPaymentMethod[0]?.id) {
      selectedPaymentMethod.removeAt(0);
      await paymentMethodService.removeSelectedPaymentMethod(removedItem);
    }

    await paymentMethodService.removePaymentMethod(removedItem);
    notifyListeners();
    return removedItem;
  }

  bool _trySetExpDate() {
    if (expDate.isNotEmpty && expDate[0] == '0') expDate = expDate.substring(1);
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

  bool _isPaymentMethodValid() {
    isNumberValid = PaymentValidator.isNumberValid(creditCard.number);
    isNameValid = PaymentValidator.iNameValid(creditCard.name);
    isDateValid = _trySetExpDate();
    isCvcValid = PaymentValidator.isCvcValid(creditCard.cvc);

    return isNumberValid && isNameValid && isDateValid && isCvcValid;
  }

  void clean() {
    creditCard = CreditCard();
    paymentMethod = PaymentMethodModel();
    expDate = '';
    isNumberValid = true;
    isNameValid = true;
    isDateValid = true;
    isCvcValid = true;
  }
}
