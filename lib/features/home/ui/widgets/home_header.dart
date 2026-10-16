import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back 👋',
              style: AppTextStyles.font13LightPeachPoppins400W,
            ),
            Text('Alex Mercer', style: AppTextStyles.font28BrownPoppins700W),
          ],
        ),
        Spacer(),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: AppColors.white,
          ),
          child: SvgPicture.asset(AppSvgs.notficationsIcon),
        ),
      ],
    );
  }
}
