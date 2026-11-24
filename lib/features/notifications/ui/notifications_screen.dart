import 'package:flutter/material.dart';
import 'package:vernita/features/notifications/ui/widgets/notifications_body.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NotificationsBody());
  }
}
