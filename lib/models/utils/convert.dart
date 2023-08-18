import 'package:intl/intl.dart';

class Convert {
  static String convertReal(double value) {
    return NumberFormat.currency(
      locale: "pt_BR",
      symbol: "R\$",
    ).format(value);
  }
}
