import 'package:flutter/material.dart';
import 'package:vernita/features/calendar/ui/widgets/add_event/add_event_body.dart';

/// 3.1 - "What do you want to add?"
class AddEventScreen extends StatelessWidget {
  const AddEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: AddEventBody());
  }
}
