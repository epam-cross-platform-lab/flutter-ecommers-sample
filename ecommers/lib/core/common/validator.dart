class UserValidator {
  static const int _minPasswordLength = 4;
  static const _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  static bool isEmail(String email) {
    final regexp = RegExp(_emailPattern);

    return regexp.hasMatch(email);
  }

  static bool isPhoneNumber(String phone) {
    const _phoneNumber = r'^[0-9]{12}$';
    final regexp = RegExp(_phoneNumber);

    return regexp.hasMatch(phone);
  }

  static bool isPasswordValid(String password) {
    return password.length >= _minPasswordLength;
  }
}
