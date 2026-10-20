import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../logic/settings_cubit.dart';
import '../../logic/settings_state.dart';

class SettingsAppSection extends StatelessWidget {
  const SettingsAppSection({super.key});

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
              onTap: () => Navigator.pushNamed(context, Routes.notifications),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (p, c) => p.settings.darkMode != c.settings.darkMode,
              builder: (context, state) => ProfileTile(
                icon: Icons.wb_sunny_outlined,
                title: 'Dark Mode',
                trailing: AppSwitch(
                  value: state.settings.darkMode,
                  onChanged: context.read<SettingsCubit>().toggleDarkMode,
                ),
              ),
            ),
            BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (p, c) => p.settings.language != c.settings.language,
              builder: (context, state) => ProfileTile(
                icon: Icons.language_rounded,
                title: 'Language',
                value: state.settings.language,
                showChevron: true,
                onTap: () {}, // TODO: language picker -> cubit.setLanguage(...)
              ),
            ),
          ],
        ),
      ],
    );
  }
}
