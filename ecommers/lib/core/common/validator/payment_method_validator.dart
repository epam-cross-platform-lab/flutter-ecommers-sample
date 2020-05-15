class PaymentValidator {
  
  static bool isNumberValid(String number) => number != null && number.length == 19;

  static bool isCvcValid(String cvc) => cvc != null && cvc?.length == 3;

  static bool iNameValid(String name) => name != null && name.length >= 3;
}
