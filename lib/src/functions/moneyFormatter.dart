import 'package:intl/intl.dart';

Future<String> formatPrice(String number, String currencySymbol) async {
  double price = double.parse(number);
  String formattedPrice = NumberFormat('#,###').format(price);
  return 'Amount: '+formattedPrice + currencySymbol;
}
