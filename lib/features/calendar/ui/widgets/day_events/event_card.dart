import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';
import 'package:vernita/features/calendar/ui/widgets/event_type_style.dart';

/// Time / title / subtitle on the left, duration + chevron on the right.
/// Tasks get a soft purple border, interviews are plain.
class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event, this.onTap});

  final CalendarEventModel event;
  final VoidCallback? onTap; // TODO: open event details

  @override
  Widget build(BuildContext context) {
    final color = event.type.color;
    final isTask = event.type == EventType.task;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(
            color: isTask ? color.withOpacity(.35) : Colors.transparent,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.fieldShadow,
              offset: Offset(0, 4),
              blurRadius: 16,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatTime(event.startAt.hour, event.startAt.minute),
                    style: AppTextStyles.font13BrownPoppins600W.copyWith(
                      color: color,
                    ),
                  ),
                  verticalSpace(2),
                  Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14BrownPoppins700W,
                  ),
                  verticalSpace(2),
                  Text(
                    event.subtitle,
                    style: AppTextStyles.font11GreyPoppins400W,
                  ),
                ],
              ),
            ),
            Text(
              '${event.durationMin} min',
              style: AppTextStyles.font12PrimaryPoppins600W.copyWith(
                color: color,
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
