import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';

/// Colors / labels per event type (orange = interview, purple = task).
extension EventTypeStyle on EventType {
  Color get color => this == EventType.interview
      ? AppColors.lightPeachText
      : AppColors.personalTask;

  String get label =>
      this == EventType.interview ? 'Interview Session' : 'Task';

  /// "Add Task" / "Add Interview" (header + button of the form).
  String get addTitle => this == EventType.interview ? 'Add Interview' : 'Add Task';

  String get nameLabel => this == EventType.interview ? 'Interview Name' : 'Task Name';

  String get nameHint => this == EventType.interview
      ? 'e.g. System design mock'
      : 'e.g. Practice behavioral questions';

  IconData get icon => this == EventType.interview
      ? Icons.mic_none_rounded
      : Icons.assignment_outlined;
}
