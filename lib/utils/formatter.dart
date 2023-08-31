import 'package:intl/intl.dart';

String formatMoney(int amount) {
  final formatter = NumberFormat('#,###');
  return formatter.format(amount);
}

String formatUniversalTime(String inputTime) {
  DateTime parsedTime = DateTime.parse(inputTime);

  String formattedTime =
      "${parsedTime.hour.toString().padLeft(2, '0')}.${parsedTime.minute.toString().padLeft(2, '0')}";

  return formattedTime;
}
