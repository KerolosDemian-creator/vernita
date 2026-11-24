import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../../widgets/status_chip.dart';
import '../../logic/security_cubit.dart';
import '../../logic/security_state.dart';

class ActiveSessionsSection extends StatelessWidget {
  const ActiveSessionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SecurityCubit, SecurityState>(
      buildWhen: (p, c) => p.sessions != c.sessions,
      builder: (context, state) => Column(
        children: [
          SectionLabel(
            'Active Sessions',
            trailing: GestureDetector(
              onTap: context.read<SecurityCubit>().logOutAll,
              child: Text(
                'Log out all',
                style: AppTextStyles.font11DangerPoppins600W,
              ),
            ),
          ),
          SectionCard(
            children: [
              for (final s in state.sessions)
                ProfileTile(
                  icon: s.isPhone
                      ? Icons.phone_iphone_rounded
                      : Icons.laptop_mac_rounded,
                  title: s.device,
                  subtitle: '${s.location} \u00b7 ${s.lastActive}',
                  trailing: s.isCurrent ? const StatusChip('Current') : null,
                  showChevron: !s.isCurrent,
                  onTap: s.isCurrent ? null : () {}, // TODO: session details
                ),
            ],
          ),
        ],
      ),
    );
  }
}
