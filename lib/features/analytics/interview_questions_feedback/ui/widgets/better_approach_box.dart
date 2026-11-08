import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class BetterApproachBox extends StatelessWidget {
  const BetterApproachBox({super.key, });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.analyticsWarningSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.analyticsWarningBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.lightbulb_outline_rounded,
                size: 14.r,
                color: AppColors.lightPeachText,
              ),

              horizantalSpace(5),

              Text(
                'Better Approach',
                style: AppTextStyles.font12BrownPoppins600W.copyWith(
                  color: AppColors.lightPeachText,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),

          verticalSpace(5),

          Text(
            'Start with requirements → identify core features → design system architecture → choose technologies → discuss scaling, reliability, and trade-offs.',
            style: AppTextStyles.font12BrownPoppins600W.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.lightBrown,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
