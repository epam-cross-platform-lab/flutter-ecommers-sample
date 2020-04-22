import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/models/payment_method_wrapper.dart';
import 'package:ecommers/core/services/dependency_service.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodService {
  PaymentMethodService() {
    _initialize();
  }

  Future _initialize() async {
    StripePayment.setOptions(StripeOptions(
      publishableKey: 'pk_test_O4MySLvZlQMSIVMEJPCQjbIv00CnR4Bawc',
      merchantId: 'Test',
      androidPayMode: 'test',
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
      final paymnentMethodModel =
          PaymentMethodModel.fromStripePaymentMethod(paymentMethod);

      await paymentMethodRepository.addPaymentMethod(
        PaymentMethodWrapper.fromPaymentMethod(paymnentMethodModel),
      );

      return paymnentMethodModel;
    } catch (ex) {
      return null;
    }
  }

  Future removePaymentMethod(PaymentMethodModel paymnentMethodModel) async {
    await paymentMethodRepository.removePaymentMethod(
      PaymentMethodWrapper.fromPaymentMethod(paymnentMethodModel),
    );
  }

  Future editPaymentMethod(PaymentMethodModel paymnentMethodModel) async {
    await paymentMethodRepository.editPaymentMethod(
      PaymentMethodWrapper.fromPaymentMethod(paymnentMethodModel),
    );
  }
}
