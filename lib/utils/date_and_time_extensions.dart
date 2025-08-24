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
}
