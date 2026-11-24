import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';

class TwoFactorSection extends StatefulWidget {
  const TwoFactorSection({super.key});

  @override
  State<TwoFactorSection> createState() => _TwoFactorSectionState();
}

class _TwoFactorSectionState extends State<TwoFactorSection> {
  bool _twoFactorEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('Two-Factor Authentication'),
        SectionCard(
          children: [
            ProfileTile(
              icon: Icons.smartphone_rounded,
              title: 'Authenticator App',
              subtitle: 'Secure your account with 2FA',
              trailing: AppSwitch(
                value: _twoFactorEnabled,
                onChanged: (isEnabled) =>
                    setState(() => _twoFactorEnabled = isEnabled),
              ),
            ),
            ProfileTile(
              icon: Icons.verified_user_outlined,
              iconBackground: AppColors.violetBg,
              iconColor: AppColors.personalTask,
              title: 'Recovery Codes',
              subtitle: 'Generate backup codes',
              showChevron: true,
              onTap: () {}, // TODO: generate recovery codes
            ),
          ],
        ),
      ],
    );
  }
}
