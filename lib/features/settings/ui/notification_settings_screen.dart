import 'package:flutter/material.dart';
import 'package:vernita/features/settings/ui/widgets/notification_settings_body.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: NotificationSettingsBody());
  }
}
