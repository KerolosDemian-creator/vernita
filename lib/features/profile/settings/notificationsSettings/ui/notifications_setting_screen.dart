import 'package:flutter/material.dart';
import '../../../widgets/profile_scaffold.dart';
import '../data/models/notification_pref_model.dart';
import 'widgets/notification_section.dart';

/// Screen 4: Notifications.
class NotificationsSettingScreen extends StatefulWidget {
  const NotificationsSettingScreen({super.key});

  @override
  State<NotificationsSettingScreen> createState() =>
      _NotificationsSettingScreenState();
}

class _NotificationsSettingScreenState
    extends State<NotificationsSettingScreen> {
  // TODO(backend): persist notification preferences
  List<NotificationPrefModel> _prefs = NotificationPrefModel.defaults;

  List<NotificationPrefModel> _prefsOf(NotificationSection section) =>
      _prefs.where((pref) => pref.section == section).toList();

  void _toggle(String id, bool isEnabled) {
    setState(() {
      _prefs = [
        for (final pref in _prefs)
          pref.id == id ? pref.copyWith(enabled: isEnabled) : pref,
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      title: 'Notifications',
      child: Column(
        children: [
          NotificationSectionView(
            label: 'Interview',
            prefs: _prefsOf(NotificationSection.interview),
            onToggle: _toggle,
          ),
          NotificationSectionView(
            label: 'Account & Security',
            prefs: _prefsOf(NotificationSection.accountSecurity),
            onToggle: _toggle,
          ),
          NotificationSectionView(
            label: 'Engagement',
            prefs: _prefsOf(NotificationSection.engagement),
            onToggle: _toggle,
          ),
        ],
      ),
    );
  }
}
