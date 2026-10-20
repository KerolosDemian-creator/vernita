import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../data/models/notification_pref_model.dart';
import '../../logic/notifications_cubit.dart';
import '../../logic/notifications_state.dart';

/// Label + card with one switch row per preference of [section].
class NotificationSectionView extends StatelessWidget {
  const NotificationSectionView({
    super.key,
    required this.label,
    required this.section,
  });

  final String label;
  final NotificationSection section;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final items = state.bySection(section);
        return Column(
          children: [
            SectionLabel(label),
            SectionCard(
              children: [
                for (final p in items)
                  ProfileTile(
                    icon: p.icon,
                    title: p.title,
                    subtitle: p.subtitle,
                    trailing: AppSwitch(
                      value: p.enabled,
                      onChanged: (v) =>
                          context.read<NotificationsCubit>().toggle(p.id, v),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
