import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class WhatYouDidWellSection extends StatelessWidget {
  const WhatYouDidWellSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.check_circle_outline_rounded,
              size: 14.r,
              color: AppColors.positiveGreen,
            ),

            horizantalSpace(5),

            Text(
              'What You Did Well',
              style: AppTextStyles.font12BrownPoppins600W.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),

        verticalSpace(6),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Container(
                  width: 5.r,
                  height: 5.r,
                  decoration: BoxDecoration(
                    color: AppColors.positiveGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              horizantalSpace(8),
              Expanded(
                child: Text(
                  'Mentioned horizontal scaling for the backend',
                  style: AppTextStyles.font12BrownPoppins600W.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBrown,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpace(4),
        Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 6.h),
                child: Container(
                  width: 5.r,
                  height: 5.r,
                  decoration: BoxDecoration(
                    color: AppColors.positiveGreen,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              horizantalSpace(8),
              Expanded(
                child: Text(
                  'Good understanding of real-time communication',
                  style: AppTextStyles.font12BrownPoppins600W.copyWith(
                    fontWeight: FontWeight.w400,
                    color: AppColors.lightBrown,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
