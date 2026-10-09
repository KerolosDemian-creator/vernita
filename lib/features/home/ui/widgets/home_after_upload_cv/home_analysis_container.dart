import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class HomeAnalysisContainer extends StatelessWidget {
  const HomeAnalysisContainer({
    super.key,
    required this.containerIcon,
    required this.txtInContaierIconRow,
    required this.firstTxt,
    required this.secondTxt,
    required this.thirdTxt,
    required this.containerColor,
    required this.bottomRow,
  });
  final SvgPicture containerIcon;
  final String txtInContaierIconRow;
  final String firstTxt;
  final String secondTxt;
  final String thirdTxt;
  final Gradient containerColor;
  final Widget bottomRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      height: 160.h,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        gradient: containerColor,
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
                child: containerIcon,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  color: AppColors.lightGreeen,
                ),
                child: Text(
                  txtInContaierIconRow,
                  style: AppTextStyles.font10OliverForestPopppins700W,
                ),
              ),
            ],
          ),
          verticalSpace(16),
          Text(
            firstTxt,
            style: AppTextStyles.font20BrownPoppins600W.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(secondTxt, style: AppTextStyles.font12LightBrownPoppins700W),
          verticalSpace(7),

          Text(
            thirdTxt,
            style: AppTextStyles.font11GreyPoppins400W.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          verticalSpace(6),
          bottomRow,
        ],
      ),
    );
  }
}
