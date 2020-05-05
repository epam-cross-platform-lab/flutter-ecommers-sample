class PaymentMethodValidator {
  static const digitPattern = r'[0-9]';
  static const firstSymbolDatePattern = r'([0-1])';

  static bool isValiExpdDate(String expDate) {
    const datePattern = r'^(0[1-9]|1[0-2])\/?([0-9]{2})$';
    final regexp = RegExp(datePattern);

    if (!regexp.hasMatch(expDate)) return false;

    final monthAndYear = expDate.split('/');
    final expMonth = int.parse(monthAndYear[0]);
    final expYear = int.parse('20${monthAndYear[1]}');

    return DateTime(expYear, expMonth).isAfter(DateTime.now());
  }

  static bool isValidCreditCard(String creditCard) {
    const creditCardPattern = 
        r'^(?:4[0-9]{12}(?:[0-9]{3})?|(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}|3[47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$';
    
    return RegExp(creditCardPattern).hasMatch(creditCard);
  }

  static bool isCVCValid(String cvc){
    const double symbolCount = 3;
    
    return cvc?.length == symbolCount;
  }

  static bool isPlaceholderName(String name){
      const namePattern = r'^([A-Za-z0-9\. -]+)';

      return RegExp(namePattern).hasMatch(name);
  }
}
