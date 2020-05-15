import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodService {
  static const String testPublishableKey =
      'pk_test_O4MySLvZlQMSIVMEJPCQjbIv00CnR4Bawc';
  static const String testMerchantId = 'Test';
  static const String testandroidPayMode = 'test';

  PaymentMethodService() {
    _initialize();
  }

  Future _initialize() async {
    StripePayment.setOptions(StripeOptions(
      publishableKey: testPublishableKey,
      merchantId: testMerchantId,
      androidPayMode: testandroidPayMode,
    ));
  }

  Future<List<PaymentMethodModel>> getPaymentMethods() async {
    return paymentMethodRepository.getAllOPaymentMethods();
  }

  Future<PaymentMethodModel> createPyamentMethod(CreditCard card) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card),
      );
      final paymentMethodModel =
          PaymentMethodModel.fromStripePaymentMethod(paymentMethod);

      await paymentMethodRepository.add(paymentMethodModel);

      return paymentMethodModel;
    } catch (ex) {
      return null;
    }
  }

  Future removePaymentMethod(PaymentMethodModel paymentMethodModel) async {
    return paymentMethodRepository.remove(paymentMethodModel);
  }

  Future editPaymentMethod(PaymentMethodModel paymentMethodModel) async {
    return paymentMethodRepository.edit(paymentMethodModel);
  }
  Future<List<PaymentMethodModel>> getSelectedPaymentMethod() async {
    return paymentMethodRepository.getSelectedPaymentMethod();
  }

  Future addSelectedPaymentMethod(PaymentMethodModel item) async {
    return paymentMethodRepository.addSelectedPaymentMethod(item);
  }

  Future updateSelectedPaymentMethod(PaymentMethodModel item) async {
    return paymentMethodRepository.updateSelectedPaymentMethod(item);
  }

  Future removeSelectedPaymentMethod(PaymentMethodModel item) async {
    return paymentMethodRepository.removeSelectedPaymentMethod(item);
  }
}
