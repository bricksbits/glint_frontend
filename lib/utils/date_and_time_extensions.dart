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

  String toChatTimestamp() {
    final now = DateTime.now();
    final difference = now.difference(this).inDays;

    if (difference == 0) {
      return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
    } else if (difference == 1) {
      return "Yesterday";
    } else {
      const months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      final monthName = months[month - 1];
      return "$day $monthName";
    }
  }
}

DateTime dateFromStandardResponse(String date) {
  return DateTime.parse(date);
}

/// Robust parser that handles all known backend date formats:
/// - ISO8601 with Z:          "2026-03-25T19:00:00Z"
/// - ISO8601 with offset:     "2026-03-25T19:00:00+00:00"
/// - Space-separated + UTC:   "2026-04-25 19:30:00 +0000 UTC"
/// - Space + UTC + microsecs: "2026-04-28 20:37:47.227472 +0000 UTC"
///
/// Returns null for null/empty/unparseable input instead of throwing.
DateTime? dateFromBackendResponse(String? raw) {
  if (raw == null || raw.trim().isEmpty) return null;

  final input = raw.trim();

  try {
    return DateTime.parse(input);
  } catch (_) {}

  // Normalize " +0000 UTC" → "Z", then space-between-date-and-time → "T",
  // then truncate microseconds to milliseconds so DateTime.parse accepts it.
  String normalized = input
      .replaceAll(' +0000 UTC', 'Z')
      .replaceFirst(' ', 'T')
      .replaceAllMapped(
        RegExp(r'\.(\d{4,6})'),
        (m) => '.${m.group(1)!.substring(0, 3)}',
      );

  try {
    return DateTime.parse(normalized);
  } catch (_) {
    return null;
  }
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
