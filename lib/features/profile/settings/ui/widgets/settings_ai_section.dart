import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../logic/settings_cubit.dart';
import '../../logic/settings_state.dart';

class SettingsAiSection extends StatelessWidget {
  const SettingsAiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('AI Interview Engine'),
        SectionCard(
          children: [
            BlocBuilder<SettingsCubit, SettingsState>(
              buildWhen: (p, c) => p.settings.aiVoice != c.settings.aiVoice,
              builder: (context, state) => ProfileTile(
                icon: Icons.record_voice_over_outlined,
                title: 'AI Voice',
                value: state.settings.aiVoice,
                showChevron: true,
                onTap: () {}, // TODO: voice picker -> cubit.setAiVoice(...)
              ),
            ),
            ProfileTile(
              icon: Icons.videocam_outlined,
              title: 'Camera & Posture Check',
              subtitle: 'Quick preview for framing & lighting before mocks',
              showChevron: true,
              onTap: () {}, // TODO: camera preview
            ),
          ],
        ),
      ],
    );
  }
}
