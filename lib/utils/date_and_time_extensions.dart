import 'package:intl/intl.dart';

extension DateTimeFormatter on DateTime {
  static final _formatter = DateFormat("yyyy-MM-dd HH:mm:ss");

  /// Formats the DateTime to "yyyy-MM-dd HH:mm:ss"
  String formatToStandard() {
    return _formatter.format(this);
  }

  /// Returns a new DateTime with added days and hours, already formatted.
  String addAndFormat({int days = 0, int hours = 0}) {
    final updated = add(Duration(days: days, hours: hours));
    return _formatter.format(updated);
  }

  /// Converts a "yyyy-MM-dd HH:mm:ss" string back to DateTime
  static DateTime fromStandardString(String dateStr) {
    return _formatter.parse(dateStr);
  }

  /// Returns the date formatted as "25 Jun".
  String toFormattedDate() {
    return DateFormat('d MMM').format(this);
  }

  /// Returns the time formatted as "4:35 PM".
  String toFormattedTime() {
    return DateFormat('h:mm a').format(this);
  }
}

DateTime dateFromStandardResponse(String date){
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  return format.parse(date);
}