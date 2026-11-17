import '../data/models/notification_pref_model.dart';

class NotificationsState {
  const NotificationsState({required this.prefs});

  final List<NotificationPrefModel> prefs;

  List<NotificationPrefModel> bySection(NotificationSection section) =>
      prefs.where((p) => p.section == section).toList();
}
