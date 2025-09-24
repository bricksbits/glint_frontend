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

  String toDayAndMonth() {
    return DateFormat('dd MMMM').format(this);
  }

  String formattedTime12Hour() => DateFormat('hh:mm a').format(this);

  /// Returns the date formatted as "25 Jun".
  String toFormattedDate() {
    return DateFormat('d MMM').format(this);
  }

  /// Returns the time formatted as "4:35 PM".
  String toFormattedTime() {
    return DateFormat('h:mm a').format(this);
  }
}

DateTime dateFromStandardResponse(String date) {
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  return format.parse(date);
}

extension DateTimeFormatting on String {
  String toFormattedDateTime() {
    // 1. Parse the ISO 8601 string into a DateTime object.
    // The Z at the end signifies that the time is in UTC.
    final dateTime = DateTime.parse(this).toLocal();

    // 2. Format the date part (Day/Month).
    final date = DateFormat('dd/MM').format(dateTime);

    // 3. Format the time part (05:00 PM).
    final time = DateFormat('hh:mm a').format(dateTime);

    // 4. Combine and return the final string.
    return '$date - $time';
  }
}
