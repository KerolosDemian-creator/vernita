import 'package:flutter/material.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';

class SettingsAccountSection extends StatelessWidget {
  const SettingsAccountSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('Account'),
        SectionCard(
          children: [
            ProfileTile(
              icon: Icons.person_outline_rounded,
              title: 'Personal Information',
              showChevron: true,
              onTap: () => Navigator.pushNamed(context, Routes.personalInfo),
            ),
            ProfileTile(
              icon: Icons.shield_outlined,
              title: 'Password & Security',
              showChevron: true,
              onTap: () => Navigator.pushNamed(context, Routes.security),
            ),
          ],
        ),
      ],
    );
  }
}
