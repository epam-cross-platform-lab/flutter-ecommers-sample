import 'package:ecommers/core/models/cache_wrappers/payment_method_wrapper.dart';
import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodService {
  static const String testPublishableKey = 'pk_test_O4MySLvZlQMSIVMEJPCQjbIv00CnR4Bawc';
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
    final paymentMethodWrapper = await paymentMethodRepository.getAllOPaymentMethods();

    return paymentMethodWrapper.map((x) => x.paymentMethodModel).toList();     
  }
  
  Future<PaymentMethodModel> createPyamentMethod(CreditCard card) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card),
      );
      final paymentMethodModel =
          PaymentMethodModel.fromStripePaymentMethod(paymentMethod);

      await paymentMethodRepository.addPaymentMethod(
        PaymentMethodWrapper.fromPaymentMethod(paymentMethodModel),
      );

      return paymentMethodModel;
    } catch (ex) {
      return null;
    }
  }

  Future removePaymentMethod(PaymentMethodModel paymentMethodModel) async {
    await paymentMethodRepository.removePaymentMethod(
      PaymentMethodWrapper.fromPaymentMethod(paymentMethodModel),
    );
  }

  Future editPaymentMethod(PaymentMethodModel paymentMethodModel) async {
    await paymentMethodRepository.editPaymentMethod(
      PaymentMethodWrapper.fromPaymentMethod(paymentMethodModel),
    );
  }
}
