import 'package:intl/intl.dart';

check_date() {
  DateTime date = DateTime.now();
  var weekday = DateFormat('EEEE').format(date);

  return weekday;
}
