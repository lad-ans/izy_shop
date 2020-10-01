import 'package:intl/intl.dart';

class NumberFormatter {
  static final NumberFormatter instance = NumberFormatter._internal();

  NumberFormatter._internal();

  factory NumberFormatter() => instance;

  String numToString(num number) => NumberFormat("###,##0.00", "pt-br")
      .format(double.parse(number.toStringAsFixed(2)));
}
