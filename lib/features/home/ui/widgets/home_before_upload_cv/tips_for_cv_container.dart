import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class TipsForCvContainer extends StatelessWidget {
  const TipsForCvContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      height: 105.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.7),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppSvgs.tipsForCvIcon),
          horizantalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tips for a great CV',
                  style: AppTextStyles.font14BrownPoppins600W,
                ),
                verticalSpace(3),
                Text(
                  'Keep it updated and relevant to increase your chances.',
                  style: AppTextStyles.font13GreyPoppins400W,
                  maxLines: 3,
                ),
              ],
            ),
          ),
          horizantalSpace(16),

          Icon(Icons.arrow_forward_ios_rounded, size: 18),
        ],
      ),
    );
  }
}
