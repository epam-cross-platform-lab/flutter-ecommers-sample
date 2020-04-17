import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    final currencyFormatter = NumberFormat.simpleCurrency();

    return currencyFormatter.format(cost);
  }

  static String getTextWithNumberCard(String nuberCard) {
    const visibleCardSymbolCount = 2;

    final visibleSymbols =
        nuberCard.substring(nuberCard.length - visibleCardSymbolCount);

    return 'Master Card ending **$visibleSymbols'; //TODO: use localization
  }

  static String getTextWithSpecifiedDateFormat(DateTime date, String format) {
    return DateFormat(format).format(date);
  }

  static String getRate(double value) {
    return value.toStringAsFixed(1);
  }

  static double getRating(int value) {
    return value + .0;
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
