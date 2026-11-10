import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/ui/widgets/event_type_style.dart';

/// Option row: [icon]  title / subtitle  >
class EventTypeCard extends StatelessWidget {
  const EventTypeCard({
    super.key,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final EventType type;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 46.r,
              height: 46.r,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.paleApricot,
              ),
              child: Icon(type.icon, size: 22.r, color: AppColors.lightPeachText),
            ),
            horizantalSpace(14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.font14BrownPoppins700W),
                  verticalSpace(2),
                  Text(subtitle, style: AppTextStyles.font11GreyPoppins400W),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 22.r,
              color: AppColors.nonSelectedIcon,
            ),
          ],
        ),
      ),
    );
  }
}
