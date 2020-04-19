import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    final currencyFormatter = NumberFormat.simpleCurrency();

    return currencyFormatter.format(cost);
  }

  static String getTextWithNumberCard(String lastFourNumber) =>'************$lastFourNumber';
  
  static String getTextWithSpecifiedDateFormat(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String getRate(double value) {
    return value.toStringAsFixed(1);
  }
}
