import 'package:flutter/material.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/ui/widgets/event_form/add_task_body.dart';

/// 3.2 - Event details form (used for both Task and Interview Session).
class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key, this.type = EventType.task});

  final EventType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: AddTaskBody(type: type));
  }
}
