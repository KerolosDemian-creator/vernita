import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/theme/app_colors.dart';
import '../../../widgets/app_switch.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../logic/security_cubit.dart';
import '../../logic/security_state.dart';

class TwoFactorSection extends StatelessWidget {
  const TwoFactorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('Two-Factor Authentication'),
        SectionCard(
          children: [
            BlocBuilder<SecurityCubit, SecurityState>(
              buildWhen: (p, c) => p.twoFactorEnabled != c.twoFactorEnabled,
              builder: (context, state) => ProfileTile(
                icon: Icons.smartphone_rounded,
                title: 'Authenticator App',
                subtitle: 'Secure your account with 2FA',
                trailing: AppSwitch(
                  value: state.twoFactorEnabled,
                  onChanged: context.read<SecurityCubit>().toggleTwoFactor,
                ),
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
