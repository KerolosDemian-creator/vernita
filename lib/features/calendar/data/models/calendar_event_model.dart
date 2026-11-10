enum EventType { interview, task }

class CalendarEventModel {
  const CalendarEventModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.startAt,
    required this.durationMin,
    this.reminderMin = 10,
    this.notes = '',
  });

  final String id;
  final EventType type;
  final String title;
  final String subtitle;
  final DateTime startAt;
  final int durationMin;

  /// Minutes before the event (0 = no reminder).
  final int reminderMin;
  final String notes;

  /// Demo data until the real API is connected.
  /// Built relative to [today] so the screen always has something to show.
  static List<CalendarEventModel> sample(DateTime today) {
    DateTime at(int dayOffset, int hour, int minute) =>
        DateTime(today.year, today.month, today.day + dayOffset, hour, minute);

    return [
      CalendarEventModel(
        id: '1',
        type: EventType.interview,
        title: 'Mock Interview',
        subtitle: 'System Design',
        startAt: at(0, 10, 30),
        durationMin: 45,
      ),
      CalendarEventModel(
        id: '2',
        type: EventType.task,
        title: 'Review CV',
        subtitle: 'Task',
        startAt: at(0, 14, 30),
        durationMin: 30,
      ),
      CalendarEventModel(
        id: '3',
        type: EventType.interview,
        title: 'Technical Interview',
        subtitle: 'Interview Session',
        startAt: at(1, 11, 0),
        durationMin: 45,
      ),
      CalendarEventModel(
        id: '4',
        type: EventType.task,
        title: 'Practice Session',
        subtitle: 'Task',
        startAt: at(3, 16, 0),
        durationMin: 30,
      ),
      CalendarEventModel(
        id: '5',
        type: EventType.interview,
        title: 'Behavioral Mock',
        subtitle: 'Interview Session',
        startAt: at(-4, 13, 0),
        durationMin: 30,
      ),
    ];
  }
}
