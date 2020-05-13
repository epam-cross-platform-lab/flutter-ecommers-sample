import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
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

  static String getShareText(Product product) {
    return '${localization.title}: ${product?.title}\n${localization.price}: ${Formatter.getCost(product?.price)}\n${localization.rate}: ${product?.rate}\n${product?.details?.brand}, ${product?.details?.category}';
  }
}
