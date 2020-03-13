import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    final currencyFormatter =  NumberFormat.simpleCurrency();
    
    return currencyFormatter.format(cost);
  }
  static String getTextWithNumberCard(String nuberCard){ 
    const visibleCardSymbolCount = 2;
    
    final visibleSymbols = nuberCard.substring(nuberCard.length - visibleCardSymbolCount);

    return 'Master Card ending **$visibleSymbols';
  }
  static String getTextWithSpecifiedDateFormat(DateTime date, String format)
  {
    return DateFormat(format).format(date);
  }
}