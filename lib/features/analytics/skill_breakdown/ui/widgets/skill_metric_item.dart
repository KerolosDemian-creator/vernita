import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_score_bar.dart';

class SkillMetricItem extends StatelessWidget {
  const SkillMetricItem({
    super.key,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.detail,
    required this.accent,
  });

  final String title;
  final int score;
  final int maxScore;
  final String detail;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font14BrownPoppins600W.copyWith(
                  fontSize: 14.sp,
                ),
              ),
            ),
            horizantalSpace(8),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$score',
                    style: AppTextStyles.font14BrownPoppins700W.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                  TextSpan(
                    text: '/$maxScore',
                    style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                      color: AppColors.lightBrown,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(6),
        AnalyticsScoreBar(
          value: maxScore > 0 ? score / maxScore : 0,
          color: accent,
        ),
        verticalSpace(6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Container(
                width: 4.r,
                height: 4.r,
                decoration: BoxDecoration(
                  color: accent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            horizantalSpace(6),
            Expanded(
              child: Text(
                detail,
                style: AppTextStyles.font12GreyPoppins400W.copyWith(
                  color: AppColors.lightBrown,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
