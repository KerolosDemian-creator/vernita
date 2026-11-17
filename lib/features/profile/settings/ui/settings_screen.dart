import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile_scaffold.dart';
import '../logic/settings_cubit.dart';
import 'widgets/settings_account_section.dart';
import 'widgets/settings_ai_section.dart';
import 'widgets/settings_app_section.dart';

/// Screen 3: Settings.
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: const ProfileScaffold(
        title: 'Settings',
        child: Column(
          children: [
            SettingsAccountSection(),
            SettingsAiSection(),
            SettingsAppSection(),
          ],
        ),
      ),
    );
  }
}
