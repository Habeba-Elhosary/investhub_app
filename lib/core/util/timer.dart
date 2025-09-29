import 'package:investhub_app/generated/LocaleKeys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class Time {
  static Time hoursAndMinutesAndSeconds(int seconds) {
    int hours = seconds ~/ 3600;
    int remainingSecondsAfterHours = seconds % 3600;
    int minutes = remainingSecondsAfterHours ~/ 60;
    int remainingSeconds = remainingSecondsAfterHours % 60;
    return Time(hours: hours, minutes: minutes, seconds: remainingSeconds);
  }

  final int hours;
  final int minutes;
  final int seconds;

  Time({required this.hours, required this.minutes, required this.seconds});

  @override
  String toString() {
    return '${hours.toString().padLeft(2, '0')} ${LocaleKeys.durationUnits_hour.tr()} ${minutes.toString().padLeft(2, '0')} ${LocaleKeys.durationUnits_minute.tr()} }';
  }
}
