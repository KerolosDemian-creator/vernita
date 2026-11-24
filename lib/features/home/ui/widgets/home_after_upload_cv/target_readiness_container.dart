import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class TargetReadinessContainer extends StatelessWidget {
  const TargetReadinessContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      height: 130.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: AppColors.targetReadinessContainerGradient,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 9.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: SvgPicture.asset(AppSvgs.targetReadinessIcon),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.blushPink,
                ),
                child: Text(
                  '-2%',
                  style: AppTextStyles.font10OliverForestPopppins700W.copyWith(
                    color: AppColors.terracottaRed,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('82%', style: AppTextStyles.font26BrownPoppins700W),
                  Text(
                    'Target Readiness',
                    style: AppTextStyles.font12LightBrownPoppins700W,
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  SizedBox(
                    width: 100.w,
                    height: 50.h,
                    child: Image.asset(AppImages.keepItUpImage),
                  ),
                  verticalSpace(5),
                  Text(
                    'Keep it up!',
                    style: AppTextStyles.font12LightBrownPoppins700W,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
