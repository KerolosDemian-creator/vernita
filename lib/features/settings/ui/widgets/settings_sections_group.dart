import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/widgets/app_switch.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/widgets/auth_snack_bar.dart';
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

  Future<void> _logOut(BuildContext context) async {
    try {
      await context.read<AuthSessionCubit>().logout();
    } on Object {
      if (context.mounted) {
        showAuthSnackBar(context, 'Could not log out. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SettingsSection(
          sectionTitle: 'ACCOUNT',
          children: [
            const SettingsItem(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
            ),
            const SettingsItem(
              icon: Icons.shield_outlined,
              title: 'Password & Security',
            ),
            SettingsItem(
              icon: Icons.logout_rounded,
              title: 'Log Out',
              showChevron: false,
              onTap: () => _logOut(context),
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
            SettingsItem(
              icon: Icons.notifications_none_rounded,
              title: 'Push Notifications',
              onTap: () => context.pushNamed(Routes.notificationSettings),
            ),
            SettingsItem(
              icon: Icons.light_mode_outlined,
              title: 'Dark Mode',
              showChevron: false,
              trailing: AppSwitch(
                value: isDarkMode,
                onChanged: onDarkModeChanged,
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
