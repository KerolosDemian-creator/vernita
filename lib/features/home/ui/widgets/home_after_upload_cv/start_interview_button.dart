import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class StartInterviewButton extends StatelessWidget {
  const StartInterviewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Start Interview', style: AppTextStyles.font15BrownPoppins700W),
          Icon(Icons.arrow_right, color: AppColors.lightPeachText, size: 30),
        ],
      ),
    );
  }
}
