import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';

/// Read-only card (Duration / Difficulty). It is not tappable on purpose:
/// the user can see these values but can't change them.
class SetupInfoCard extends StatelessWidget {
  const SetupInfoCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
      child: Column(
        children: [
          Icon(icon, size: 20.r, color: AppColors.nonSelectedIcon),
          verticalSpace(6),
          Text(label, style: AppTextStyles.font11GreyPoppins400W),
          verticalSpace(2),
          Text(
            value,
            textAlign: TextAlign.center,
            style: AppTextStyles.font14BrownPoppins700W,
          ),
        ],
      ),
    );
  }
}
