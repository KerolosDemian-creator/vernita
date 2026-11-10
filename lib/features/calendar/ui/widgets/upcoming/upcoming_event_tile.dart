import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';
import 'package:vernita/features/calendar/ui/widgets/event_type_style.dart';

/// "OCT 18   Technical Interview   11:00 AM  >"
class UpcomingEventTile extends StatelessWidget {
  const UpcomingEventTile({super.key, required this.event, this.onTap});

  final CalendarEventModel event;
  final VoidCallback? onTap; // TODO: open event details

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            SizedBox(
              width: 38.w,
              child: Column(
                children: [
                  Text(
                    shortMonthName(event.startAt.month).toUpperCase(),
                    style: AppTextStyles.font10LightBrownPoppins600W,
                  ),
                  Text(
                    '${event.startAt.day}',
                    style: AppTextStyles.font14BrownPoppins700W,
                  ),
                ],
              ),
            ),
            horizantalSpace(12),
            Expanded(
              child: Text(
                event.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font13BrownPoppins600W,
              ),
            ),
            Text(
              formatTime(event.startAt.hour, event.startAt.minute),
              style: AppTextStyles.font12PrimaryPoppins600W.copyWith(
                color: event.type.color,
              ),
            ),
            horizantalSpace(4),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: AppColors.nonSelectedIcon,
            ),
          ],
        ),
      ),
    );
  }
}
