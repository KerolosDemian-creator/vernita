import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';

class QuestionAnalyticsCard extends StatelessWidget {
  const QuestionAnalyticsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      radius: 18.r,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.r,
            height: 40.r,
            decoration: BoxDecoration(
              color: AppColors.softLilac,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.bar_chart_rounded,
              size: 22.r,
              color: AppColors.personalTask,
            ),
          ),

          horizantalSpace(12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'View Question Analytics',
                  style: AppTextStyles.font13BrownPoppins500W.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                  ),
                ),

                verticalSpace(2),

                Text(
                  'See performance by topic and question type',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font11GreyPoppins400W.copyWith(
                    color: AppColors.lightBrown,
                    fontSize: 10.5.sp,
                  ),
                ),
              ],
            ),
          ),

          horizantalSpace(8),

          Icon(
            Icons.chevron_right_rounded,
            size: 20.r,
            color: AppColors.lightBrown,
          ),
        ],
      ),
    );
  }
}
