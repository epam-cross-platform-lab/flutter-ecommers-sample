import 'package:intl/intl.dart';

class Formatter {
  static String getCost(double cost) {
    var currencyFormatter =  NumberFormat.simpleCurrency();
    
    return currencyFormatter.format(cost);
  }
  static String getTextWithNumberCard(String nuberCard){ 
    const visibleCardSymbolCount = 2;
    
    var visibleSymbols = nuberCard.substring(nuberCard.length - visibleCardSymbolCount);

    return 'Master Card ending **$visibleSymbols';
  }
}