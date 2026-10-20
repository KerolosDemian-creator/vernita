import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../widgets/info_tile.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/status_chip.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../data/models/user_model.dart';

class CareerTargetCard extends StatelessWidget {
  const CareerTargetCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Career Target',
      children: [
        InfoTile(
          icon: Icons.business_center_outlined,
          label: 'Target Track',
          value: user.targetTrack,
          showChevron: true,
          onTap: () {}, // TODO: edit target track
        ),
        InfoTile(
          icon: Icons.description_outlined,
          label: 'Uploaded CV / Resume',
          value: user.cvFileName,
          valueWidget: Row(
            children: [
              Flexible(
                child: Text(
                  user.cvFileName,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12GreyPoppins400W,
                ),
              ),
              SizedBox(width: 6.w),
              const StatusChip('Parsed by AI'),
            ],
          ),
          onTap: () {}, // TODO: open / replace CV
        ),
      ],
    );
  }
}
