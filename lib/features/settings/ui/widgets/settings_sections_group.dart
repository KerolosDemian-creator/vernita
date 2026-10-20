import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/settings/ui/widgets/settings_item.dart';
import 'package:vernita/features/settings/ui/widgets/settings_section.dart';

class SettingsSectionsGroup extends StatelessWidget {
  const SettingsSectionsGroup({
    super.key,
    required this.isDarkMode,
    required this.onDarkModeChanged,
  });

  final bool isDarkMode;
  final ValueChanged<bool> onDarkModeChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SettingsSection(
          sectionTitle: 'ACCOUNT',
          children: [
            SettingsItem(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
            ),
            SettingsItem(
              icon: Icons.shield_outlined,
              title: 'Password & Security',
            ),
          ],
        ),
        verticalSpace(24),
        const SettingsSection(
          sectionTitle: 'AI INTERVIEW ENGINE',
          children: [
            SettingsItem(
              icon: Icons.mic_none_rounded,
              title: 'AI Voice',
              value: 'Sarah (US)',
            ),
            SettingsItem(
              icon: Icons.videocam_outlined,
              title: 'Camera & Posture Check',
              subtitle: 'Quick preview for framing & lighting before mocks',
            ),
          ],
        ),
        verticalSpace(24),
        SettingsSection(
          sectionTitle: 'APP SETTINGS',
          children: [
            const SettingsItem(
              icon: Icons.notifications_none_rounded,
              title: 'Push Notifications',
            ),
            SettingsItem(
              icon: Icons.light_mode_outlined,
              title: 'Dark Mode',
              showChevron: false,
              trailing: Switch(
                value: isDarkMode,
                onChanged: onDarkModeChanged,
                activeThumbColor: AppColors.white,
                activeTrackColor: AppColors.lightPeachText,
                inactiveThumbColor: AppColors.white,
                inactiveTrackColor: AppColors.lightBrown.withValues(alpha: .25),
                trackOutlineColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SettingsItem(
              icon: Icons.language_rounded,
              title: 'Language',
              value: 'English',
            ),
          ],
        ),
      ],
    );
  }
}
