import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/logic/calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarState.initial());

  /// Also jumps to that month when a faded day (other month) is tapped.
  void selectDate(DateTime date) => emit(
        state.copyWith(
          selectedDate: date,
          focusedMonth: DateTime(date.year, date.month),
        ),
      );

  void changeMonth(int delta) {
    final m = state.focusedMonth;
    emit(state.copyWith(focusedMonth: DateTime(m.year, m.month + delta)));
  }

  /// Adds the event to the currently selected day.
  void addEvent({
    required EventType type,
    required String title,
    required int hour,
    required int minute,
    required int reminderMin,
    String notes = '',
  }) {
    final day = state.selectedDate;
    final event = CalendarEventModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      title: title,
      subtitle: type == EventType.interview ? 'Interview Session' : 'Task',
      startAt: DateTime(day.year, day.month, day.day, hour, minute),
      durationMin: type == EventType.interview ? 45 : 30,
      reminderMin: reminderMin,
      notes: notes,
    );
    emit(state.copyWith(events: [...state.events, event]));
  }
}
