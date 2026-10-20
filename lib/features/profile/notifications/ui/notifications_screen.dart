import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile_scaffold.dart';
import '../data/models/notification_pref_model.dart';
import '../logic/notifications_cubit.dart';
import 'widgets/notification_section.dart';

/// Screen 4: Notifications.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotificationsCubit(),
      child: const ProfileScaffold(
        title: 'Notifications',
        child: Column(
          children: [
            NotificationSectionView(
              label: 'Interview',
              section: NotificationSection.interview,
            ),
            NotificationSectionView(
              label: 'Account & Security',
              section: NotificationSection.accountSecurity,
            ),
            NotificationSectionView(
              label: 'Engagement',
              section: NotificationSection.engagement,
            ),
          ],
        ),
      ),
    );
  }
}
