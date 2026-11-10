import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';

class CalendarState {
  const CalendarState({
    required this.today,
    required this.focusedMonth,
    required this.selectedDate,
    required this.events,
  });

  factory CalendarState.initial() {
    final today = dateOnly(DateTime.now());
    return CalendarState(
      today: today,
      focusedMonth: DateTime(today.year, today.month),
      selectedDate: today,
      events: CalendarEventModel.sample(today),
    );
  }

  final DateTime today;
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final List<CalendarEventModel> events;

  bool get isSelectedToday => isSameDay(selectedDate, today);

  /// Events of one day, sorted by time.
  List<CalendarEventModel> eventsOn(DateTime day) =>
      events.where((e) => isSameDay(e.startAt, day)).toList()
        ..sort((a, b) => a.startAt.compareTo(b.startAt));

  List<CalendarEventModel> get selectedDayEvents => eventsOn(selectedDate);

  /// Next events after the selected day.
  List<CalendarEventModel> get upcoming {
    final list = events
        .where((e) => dateOnly(e.startAt).isAfter(selectedDate))
        .toList()
      ..sort((a, b) => a.startAt.compareTo(b.startAt));
    return list.take(5).toList();
  }

  CalendarState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDate,
    List<CalendarEventModel>? events,
  }) =>
      CalendarState(
        today: today,
        focusedMonth: focusedMonth ?? this.focusedMonth,
        selectedDate: selectedDate ?? this.selectedDate,
        events: events ?? this.events,
      );
}
