import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/profile_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../../widgets/status_chip.dart';
import '../../data/models/session_model.dart';

class ActiveSessionsSection extends StatelessWidget {
  const ActiveSessionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionLabel(
          'Active Sessions',
          trailing: GestureDetector(
            onTap: () {}, // TODO(backend): revoke other sessions
            child: Text(
              'Log out all',
              style: AppTextStyles.font11DangerPoppins600W,
            ),
          ),
        ),
        SectionCard(
          children: [
            for (final session in SessionModel.mock)
              ProfileTile(
                icon: session.isPhone
                    ? Icons.phone_iphone_rounded
                    : Icons.laptop_mac_rounded,
                title: session.device,
                subtitle: '${session.location} \u00b7 ${session.lastActive}',
                trailing: session.isCurrent
                    ? const StatusChip('Current')
                    : null,
                showChevron: !session.isCurrent,
                onTap: session.isCurrent ? null : () {}, // TODO: session details
              ),
          ],
        ),
      ],
    );
  }
}
