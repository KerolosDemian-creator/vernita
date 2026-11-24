import 'package:flutter/material.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';

class SettingsAiSection extends StatelessWidget {
  const SettingsAiSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('AI Interview Engine'),
        SectionCard(
          children: [
            ProfileTile(
              icon: Icons.record_voice_over_outlined,
              title: 'AI Voice',
              value: 'Sarah (US)',
              showChevron: true,
              onTap: () {}, // TODO(backend): voice picker
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
