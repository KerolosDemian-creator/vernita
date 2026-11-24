import 'package:flutter/material.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';

class SettingsAppSection extends StatefulWidget {
  const SettingsAppSection({super.key});

  @override
  State<SettingsAppSection> createState() => _SettingsAppSectionState();
}

class _SettingsAppSectionState extends State<SettingsAppSection> {
  // TODO(backend): fetch settings (dark mode, language, AI voice)
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('App Settings'),
        SectionCard(
          children: [
            ProfileTile(
              icon: Icons.notifications_none_rounded,
              title: 'Push Notifications',
              showChevron: true,
              onTap: () =>
                  Navigator.pushNamed(context, Routes.notificationSettings),
            ),
            ProfileTile(
              icon: Icons.wb_sunny_outlined,
              title: 'Dark Mode',
              trailing: AppSwitch(
                value: _darkMode,
                onChanged: (isEnabled) =>
                    setState(() => _darkMode = isEnabled),
              ),
            ),
            ProfileTile(
              icon: Icons.language_rounded,
              title: 'Language',
              value: 'English',
              showChevron: true,
              onTap: () {}, // TODO(backend): language
            ),
          ],
        ),
      ],
    );
  }
}
