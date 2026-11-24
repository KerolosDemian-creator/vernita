import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/models/notification_pref_model.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit()
      : super(const NotificationsState(prefs: NotificationPrefModel.defaults));

  void toggle(String id, bool value) {
    final updated = [
      for (final p in state.prefs) p.id == id ? p.copyWith(enabled: value) : p,
    ];
    emit(NotificationsState(prefs: updated));
    // TODO: persist the change (API / local storage).
  }
}
