import 'package:intl/intl.dart';

class HelperMethods{



  static String formatMoney(double money){
    return NumberFormat.decimalPattern().format(money);
  }
}