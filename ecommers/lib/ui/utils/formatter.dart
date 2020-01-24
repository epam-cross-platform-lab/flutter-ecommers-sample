import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    var currencyFormatter =  NumberFormat.simpleCurrency();
    
    return currencyFormatter.format(cost);
  }
}