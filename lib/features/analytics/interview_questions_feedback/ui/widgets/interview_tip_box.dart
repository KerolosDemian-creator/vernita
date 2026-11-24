import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class InterviewTipBox extends StatelessWidget {
  const InterviewTipBox({super.key, });


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.analyticsDangerSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.analyticsDangerBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: SvgPicture.asset(
              AppSvgs.redAiInsightsIcon,
              width: 15.w,
              height: 15.w,
            ),
          ),

          horizantalSpace(6),

          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Tip: ',
                    style: AppTextStyles.font12BrownPoppins600W.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.lightBrown,
                      fontSize: 12.sp,
                    ),
                  ),

                  TextSpan(
                    text:
                        'Tip: Use diagrams to support your explanation for system design questions',
                    style: AppTextStyles.font12BrownPoppins600W.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.lightBrown,
                      fontSize: 12.sp,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
