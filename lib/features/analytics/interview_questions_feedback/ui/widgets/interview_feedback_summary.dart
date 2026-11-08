import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class InterviewFeedbackSummary extends StatelessWidget {
  const InterviewFeedbackSummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 1.h),
              child: Icon(
                Icons.calendar_today_outlined,
                size: 14.r,
                color: AppColors.nonSelectedIcon,
              ),
            ),
            horizantalSpace(6),
            Expanded(
              child: Text(
                'System Design Interview • Aug 26, 2024 • 10:30 AM',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font12BrownPoppins600W.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBrown,
                  fontSize: 11.sp,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
        verticalSpace(4),
        Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: Text(
            '• 45 min',
            style: AppTextStyles.font11GreyPoppins400W.copyWith(
              color: AppColors.lightBrown,
              fontSize: 10.sp,
            ),
          ),
        ),
        verticalSpace(14),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: const [
            _FeedbackFilterChip(label: 'All Questions', selected: true),
            _FeedbackFilterChip(label: 'Needs Improvement'),
            _FeedbackFilterChip(
              label: 'Filter',
              icon: Icons.filter_alt_outlined,
            ),
          ],
        ),
        verticalSpace(10),
        Text(
          '18 Questions • 12 Good • 4 Needs Improvement • 2 Wrong',
          style: AppTextStyles.font11GreyPoppins400W.copyWith(
            color: AppColors.lightBrown,
            fontSize: 10.sp,
            height: 1.35,
          ),
        ),
      ],
    );
  }
}

class _FeedbackFilterChip extends StatelessWidget {
  const _FeedbackFilterChip({
    required this.label,
    this.selected = false,
    this.icon,
  });

  final String label;
  final bool selected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.lightPeachText : AppColors.lightBrown;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(
          color: selected
              ? AppColors.lightPeachText
              : AppColors.analyticsDivider,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 13.r, color: color),
            horizantalSpace(4),
          ],
          Text(
            label,
            style: AppTextStyles.font11GreyPoppins400W.copyWith(
              color: color,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              fontSize: 10.5.sp,
            ),
          ),
        ],
      ),
    );
  }
}
