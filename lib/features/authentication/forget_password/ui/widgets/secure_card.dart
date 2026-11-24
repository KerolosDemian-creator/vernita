import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// "Secure & Safe" info card.
class SecureCard extends StatelessWidget {
  const SecureCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: AppColors.selectedIcon,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              size: 19.r,
              color: AppColors.lightPeachText,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure & Safe',
                  style: AppTextStyles.font14BrownPoppins600W.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "We'll never share your email with anyone else.",
                  style: AppTextStyles.font12GreyPoppins400W.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
