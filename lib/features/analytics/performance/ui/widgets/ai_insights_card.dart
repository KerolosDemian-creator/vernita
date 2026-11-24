import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AiInsightsCard extends StatelessWidget {
  const AiInsightsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppSvgs.aiInsightsIcon,
                width: 20.w,
                height: 20.w,
              ),
              horizantalSpace(8),
              Expanded(
                child: Text(
                  'AI Insights & Feedback',
                  maxLines: 2,
                  style: AppTextStyles.font20BrownPoppins700W.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(14),
          const _InsightItem(
            text:
                'Strong visual engagement: 84% steady eye contact maintained.',
          ),
          verticalSpace(10),
          const _InsightItem(
            text:
                'Technical accuracy was high, but answer structure lost momentum towards the end.',
          ),
          verticalSpace(10),
          const _InsightItem(
            text:
                'High-priority focus: Pacing speeds up during complex explanations.',
            isHighlighted: true,
          ),
        ],
      ),
    );
  }
}

class _InsightItem extends StatelessWidget {
  const _InsightItem({required this.text, this.isHighlighted = false});

  final String text;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    return Text(
      '• $text',
      style: AppTextStyles.font14BrownPoppins600W.copyWith(
        fontWeight: FontWeight.w400,
        color: isHighlighted ? AppColors.lightPeachText : AppColors.lightBrown,
        height: 1.45,
      ),
    );
  }
}
