import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/data/models/calendar_event_model.dart';
import 'package:vernita/features/calendar/ui/widgets/event_type_style.dart';

/// One day: number circle + small dots for the event types of that day.
class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    super.key,
    required this.day,
    required this.isCurrentMonth,
    required this.isSelected,
    required this.isToday,
    required this.eventTypes,
    required this.onTap,
  });

  final DateTime day;
  final bool isCurrentMonth;
  final bool isSelected;
  final bool isToday;
  final Set<EventType> eventTypes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected
        ? Colors.white
        : isCurrentMonth
            ? AppColors.brownText
            : AppColors.nonSelectedIcon;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        height: 42.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30.r,
              height: 30.r,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.lightPeachText : null,
                border: isToday && !isSelected
                    ? Border.all(color: AppColors.lightPeachText)
                    : null,
              ),
              child: Text(
                '${day.day}',
                style: AppTextStyles.font13BrownPoppins500W.copyWith(
                  color: textColor,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            _Dots(types: eventTypes),
          ],
        ),
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.types});

  final Set<EventType> types;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 4.r,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final type in types)
            Container(
              width: 4.r,
              height: 4.r,
              margin: EdgeInsets.symmetric(horizontal: 1.r),
              decoration: BoxDecoration(shape: BoxShape.circle, color: type.color),
            ),
        ],
      ),
    );
  }
}
