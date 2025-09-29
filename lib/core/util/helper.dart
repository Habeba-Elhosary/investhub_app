import 'package:easy_localization/easy_localization.dart';

abstract class DateTimeHelper {
 static String formatDate(DateTime dateTime) {
    final day = DateFormat('d').format(dateTime);
    final month = DateFormat('MMMM', 'ar_SA').format(dateTime);
    final year = DateFormat('y').format(dateTime);

    return '$day $month $year';
  }

 static String formatTime(DateTime dateTime) {
    final time = DateFormat('hh:mm').format(dateTime);
    final period = DateFormat('a', 'ar').format(dateTime);

    return '$time $period';
  }
}