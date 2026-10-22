import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class CvLoadingContainer extends StatelessWidget {
  const CvLoadingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 290.h,
      width: double.infinity,
      padding: EdgeInsets.all(24.r),
      decoration: BoxDecoration(
        color: AppColors.warmCream,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColors.warmPeach),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 42.r,
            height: 42.r,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: AppColors.lightPeachText,
              backgroundColor: AppColors.warmPeach,
            ),
          ),
          verticalSpace(24),
          Text(
            'Checking your CV...',
            style: AppTextStyles.font14BrownPoppins600W,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Please wait while we validate your file.',
            style: AppTextStyles.font12GreyPoppins400W,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
