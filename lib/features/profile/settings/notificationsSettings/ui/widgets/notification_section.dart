import 'package:flutter/material.dart';
import '../../../../widgets/app_switch.dart';
import '../../../../widgets/profile_tile.dart';
import '../../../../widgets/section_card.dart';
import '../../../../widgets/section_label.dart';
import '../../data/models/notification_pref_model.dart';

/// Label + card with one switch row per preference in [prefs].
class NotificationSectionView extends StatelessWidget {
  const NotificationSectionView({
    super.key,
    required this.label,
    required this.prefs,
    required this.onToggle,
  });

  final String label;
  final List<NotificationPrefModel> prefs;
  final void Function(String id, bool isEnabled) onToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionLabel(label),
        SectionCard(
          children: [
            for (final pref in prefs)
              ProfileTile(
                icon: pref.icon,
                title: pref.title,
                subtitle: pref.subtitle,
                trailing: AppSwitch(
                  value: pref.enabled,
                  onChanged: (isEnabled) => onToggle(pref.id, isEnabled),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
