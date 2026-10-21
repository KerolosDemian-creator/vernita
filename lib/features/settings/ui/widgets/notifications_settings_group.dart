import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/widgets/app_switch.dart';
import 'package:vernita/features/settings/ui/widgets/settings_item.dart';
import 'package:vernita/features/settings/ui/widgets/settings_section.dart';

// This screen is UI-only for now; the switches intentionally do not store state.
void _onSwitchChanged(bool _) {}

class NotificationsSettingsGroup extends StatelessWidget {
  const NotificationsSettingsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSection(
          sectionTitle: 'INTERVIEW',
          children: [
            SettingsItem(
              icon: Icons.calendar_month_outlined,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Scheduled Reminders',
              subtitle: 'Get reminded before your sessions',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
            SettingsItem(
              icon: Icons.verified_outlined,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Performance Insights',
              subtitle: 'Weekly score updates and tips',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
            SettingsItem(
              icon: Icons.bolt_outlined,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'New AI Features',
              subtitle: 'When new interview modes drop',
              showChevron: false,
              trailing: AppSwitch(value: false, onChanged: _onSwitchChanged),
            ),
          ],
        ),
        verticalSpace(24),
        const SettingsSection(
          sectionTitle: 'ACCOUNT & SECURITY',
          children: [
            SettingsItem(
              icon: Icons.verified_user_outlined,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Security Alerts',
              subtitle: 'Suspicious login attempts',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
          ],
        ),
        verticalSpace(24),
        const SettingsSection(
          sectionTitle: 'ENGAGEMENT',
          children: [
            SettingsItem(
              icon: Icons.trending_up_rounded,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Streak Reminders',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
            SettingsItem(
              icon: Icons.auto_awesome_outlined,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Achievements',
              subtitle: 'Celebrate your milestones',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
            SettingsItem(
              icon: Icons.chat_bubble_outline_rounded,
              iconBackgroundColor: AppColors.paleApricot,
              title: 'Tips & Motivation',
              subtitle: 'Useful tips and motivation to keep going',
              showChevron: false,
              trailing: AppSwitch(value: true, onChanged: _onSwitchChanged),
            ),
          ],
        ),
      ],
    );
  }
}
