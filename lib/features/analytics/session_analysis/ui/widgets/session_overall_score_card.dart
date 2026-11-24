import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';

class SessionOverallScoreCard extends StatelessWidget {
  const SessionOverallScoreCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 4.h,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      'OVERALL SCORE',
                      style: AppTextStyles.font12BrowPoppins600W.copyWith(
                        color: AppColors.lightBrown,
                        fontSize: 11.sp,
                        letterSpacing: 1.1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 3.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.positiveGreenSurface,
                        borderRadius: BorderRadius.circular(50.r),
                      ),
                      child: Text(
                        '+5%',
                        style: AppTextStyles.font10OliverForestPopppins700W
                            .copyWith(color: AppColors.positiveGreen),
                      ),
                    ),
                  ],
                ),
              ),
              horizantalSpace(8),
              Text(
                'Oct 24 • Mock #14',
                textAlign: TextAlign.right,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                  color: AppColors.lightBrown,
                  fontSize: 11.sp,
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '84',
                            style: AppTextStyles.font40BrownPoppins700W
                                .copyWith(fontSize: 42.sp, height: 0.95),
                          ),
                          TextSpan(
                            text: '/100',
                            style: AppTextStyles.font20BrownPoppins700W
                                .copyWith(
                                  fontSize: 16.sp,
                                  height: 1,
                                  color: AppColors.lightBrown,
                                ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(10),
                    Row(
                      children: [
                        Container(
                          width: 5.r,
                          height: 5.r,
                          decoration: const BoxDecoration(
                            color: AppColors.lightPeachText,
                            shape: BoxShape.circle,
                          ),
                        ),
                        horizantalSpace(6),
                        Expanded(
                          child: Text(
                            'Top 15% of all candidates',
                            style: AppTextStyles.font12BrownPoppins600W
                                .copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.lightBrown,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              horizantalSpace(10),
              _ScoreRing(percent: 84, label: 'Great Job!'),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.percent, required this.label});

  final int percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 92.r,
      height: 92.r,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.lightPeachText, width: 3.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.star_rounded, color: AppColors.lightPeachText, size: 17.r),
          Text(
            '$percent%',
            style: AppTextStyles.font20BrownPoppins700W.copyWith(
              fontSize: 18.sp,
              height: 1.05,
            ),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
              color: AppColors.lightPeachText,
              fontSize: 9.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
