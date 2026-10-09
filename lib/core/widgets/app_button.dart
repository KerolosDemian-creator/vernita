import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        margin: EdgeInsets.symmetric(horizontal: 27.w),
        decoration: BoxDecoration(
          gradient: AppColors.buttonGradient,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.file_upload_outlined, color: AppColors.brownText),
            horizantalSpace(4),
            Text('Choose file', style: AppTextStyles.font16BrownInter600W),
          ],
        ),
      ),
    );
  }
}
