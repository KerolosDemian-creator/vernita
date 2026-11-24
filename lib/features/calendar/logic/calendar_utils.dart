/// Small date helpers (no Flutter / intl needed).

const _months = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December',
];

const _weekdays = [
  'Monday', 'Tuesday', 'Wednesday', 'Thursday',
  'Friday', 'Saturday', 'Sunday',
];

/// Week starts on Sunday, like the design.
const weekdayLetters = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

String monthName(int month) => _months[month - 1];

String shortMonthName(int month) => monthName(month).substring(0, 3);

String weekdayName(int weekday) => _weekdays[weekday - 1];

DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);

bool isSameDay(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

/// "10:30 AM" (always English digits / AM-PM, whatever the device locale).
String formatTime(int hour, int minute) {
  final h = hour % 12 == 0 ? 12 : hour % 12;
  final m = minute.toString().padLeft(2, '0');
  return '$h:$m ${hour < 12 ? 'AM' : 'PM'}';
}

/// "Friday, October 17"
String formatLongDate(DateTime d) =>
    '${weekdayName(d.weekday)}, ${monthName(d.month)} ${d.day}';

/// 42 days (6 weeks) to draw the month grid, starting on a Sunday.
/// Includes the faded days of the previous / next month.
List<DateTime> monthGridDays(DateTime month) {
  final first = DateTime(month.year, month.month, 1);
  final leading = first.weekday % 7; // Sunday = 0
  return List.generate(
    42,
    (i) => DateTime(month.year, month.month, 1 - leading + i),
  );
}

const reminderOptions = [0, 5, 10, 15, 30, 60];

String reminderLabel(int minutes) {
  if (minutes == 0) return 'No reminder';
  if (minutes == 60) return '1 hour before';
  return '$minutes minutes before';
}
