import 'package:intl/intl.dart';

String formatMoney(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}
