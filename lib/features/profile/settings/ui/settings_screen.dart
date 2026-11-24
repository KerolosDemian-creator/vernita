import 'package:flutter/material.dart';
import '../../widgets/profile_scaffold.dart';
import 'widgets/settings_account_section.dart';
import 'widgets/settings_ai_section.dart';
import 'widgets/settings_app_section.dart';

/// Screen 3: Settings.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScaffold(
      title: 'Settings',
      child: Column(
        children: [
          SettingsAccountSection(),
          SettingsAiSection(),
          SettingsAppSection(),
        ],
      ),
    );
  }
}
