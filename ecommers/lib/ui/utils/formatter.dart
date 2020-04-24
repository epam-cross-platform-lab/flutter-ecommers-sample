import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    final currencyFormatter = NumberFormat.simpleCurrency();

    return currencyFormatter.format(cost);
  }

  static String getTextWithNumberCard(String lastFourNumber) {
    if (lastFourNumber == null || lastFourNumber.isEmpty) return null;

    return '************$lastFourNumber';
  }

  static String getTextWithSpecifiedDateFormat(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String getRate(double value) {
    return value.toStringAsFixed(1);
  }

  static String getAlias(String firstName, String lastName) {
    return firstName?.isNotEmpty == true && lastName?.isNotEmpty == true
        ? '${firstName[0]}${lastName[0]}'
        : '';
  }

  static String getUserName(String firstName, String lastName) {
    return firstName?.isNotEmpty == true && lastName?.isNotEmpty == true
        ? '$firstName $lastName'
        : 'No Name';
  }
}
