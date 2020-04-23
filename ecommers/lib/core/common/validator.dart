class Validator {
  static const int _minPasswordLength = 4;
  static const _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"; 

  static bool isEmail(String email) {
    final regexp = RegExp(_emailPattern);

    return regexp.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    return password.length >= _minPasswordLength;
  }
}
