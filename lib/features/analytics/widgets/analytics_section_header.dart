import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AnalyticsSectionHeader extends StatelessWidget {
  const AnalyticsSectionHeader({
    super.key,
    required this.title,
    required this.onViewAll,
    this.titleMaxLines = 1,
  });

  final String title;
  final VoidCallback onViewAll;
  final int titleMaxLines;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: titleMaxLines,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font20BrownPoppins700W.copyWith(
              fontSize: 18.sp,
              height: 1.15,
            ),
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onViewAll,
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, top: 2.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All',
                  style: AppTextStyles.font13LightPeachPoppins700W,
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.lightPeachText,
                  size: 17.r,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
