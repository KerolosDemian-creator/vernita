import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_score_bar.dart';

class SkillBreakdownItem extends StatelessWidget {
  const SkillBreakdownItem({
    super.key,
    required this.icon,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.barColor,
    required this.highlight,
    required this.detail,
    required this.highlightColor,
  });

  final IconData icon;
  final String title;
  final int score;
  final int maxScore;
  final Color barColor;
  final String highlight;
  final String detail;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 18.r,
              color: AppColors.nonSelectedIcon,
            ),
            horizantalSpace(10),
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
        verticalSpace(8),
        AnalyticsScoreBar(
          value: score / maxScore,
          color: barColor,
        ),
        verticalSpace(8),
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 4.w,
          runSpacing: 4.h,
          children: [
            Container(
              width: 4.r,
              height: 4.r,
              decoration: BoxDecoration(
                color: highlightColor,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              highlight,
              style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                color: highlightColor,
                fontWeight: FontWeight.w700,
                fontSize: 11.sp,
              ),
            ),
            Text(
              '• $detail',
              style: AppTextStyles.font11GreyPoppins400W.copyWith(
                color: AppColors.lightBrown,
                height: 1.35,
              ),
            ),
          ],
        ),
      ],
    );
  }
}