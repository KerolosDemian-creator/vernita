import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class TodayChip extends StatelessWidget {
  const TodayChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColors.paleApricot,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Text(
        'TODAY',
        style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
          fontSize: 9.sp,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
