class UserValidator {
  static const int _minPasswordLength = 4;
  static const _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"; 

  static bool isEmail(String email) {
    final regexp = RegExp(_emailPattern);

    return regexp.hasMatch(email);
  }

  static bool isPhoneNumber(String email) {
    const _emailPattern = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';

    final regexp = RegExp(_emailPattern);

    return regexp.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.length >= _minPasswordLength;
  }
}
