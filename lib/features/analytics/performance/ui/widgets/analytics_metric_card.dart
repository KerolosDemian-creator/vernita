import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AnalyticsMetricCard extends StatelessWidget {
  const AnalyticsMetricCard({
    super.key,
    required this.icon,
    required this.value,
    required this.title,
    this.description,
    this.improvement,
  }) : assert(description != null || improvement != null);

  final IconData icon;
  final String value;
  final String title;
  final String? description;
  final String? improvement;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 148.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.nonSelectedIcon, size: 22.r),
          verticalSpace(8),
          Text(
            value,
            style: AppTextStyles.font28BrownPoppins700W.copyWith(
              height: 1.05,
              fontSize: 24.sp,
            ),
          ),
          verticalSpace(6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font12BrownPoppins700W.copyWith(height: 1.2),
          ),
          if (description != null) ...[
            verticalSpace(6),
            Text(
              description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.font12GreyPoppins400W.copyWith(height: 1.3),
            ),
          ],
          if (improvement != null) ...[
            verticalSpace(8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
              decoration: BoxDecoration(
                color: AppColors.positiveGreenSurface,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Text(
                improvement!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font10OliverForestPopppins700W.copyWith(
                  color: AppColors.positiveGreen,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
