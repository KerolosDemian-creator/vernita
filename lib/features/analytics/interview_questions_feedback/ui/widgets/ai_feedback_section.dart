import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AiFeedbackSection extends StatelessWidget {
  const AiFeedbackSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              AppSvgs.redAiInsightsIcon,
              width: 16.w,
              height: 16.w,
            ),

            horizantalSpace(6),

            Text(
              'AI Feedback',
              style: AppTextStyles.font12BrownPoppins600W.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),

        verticalSpace(6),

        Text(
          'You provided a good high-level overview but missed some key '
          "components. You also didn't explain how your design handles "
          'message delivery guarantees.',
          style: AppTextStyles.font12BrownPoppins600W.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.lightBrown,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
