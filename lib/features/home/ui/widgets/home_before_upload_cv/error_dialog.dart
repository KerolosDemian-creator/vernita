import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class ErrorDialog extends StatelessWidget {
  final VoidCallback onReturnHome;

  const ErrorDialog({super.key, required this.onReturnHome});

  static Future<void> show(
    BuildContext context, {
    required VoidCallback onReturnHome,
  }) {
    return showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.4),
      builder: (_) => ErrorDialog(onReturnHome: onReturnHome),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 28.h, 16.w, 16.h),
        decoration: BoxDecoration(
          gradient: AppColors.lightLinearBg,
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Access Denied', style: AppTextStyles.font20BrownPoppins600W),
            verticalSpace(16),
            Text(
              'You must first upload your CV/Resume on your profile to access interview features',
              textAlign: TextAlign.center,
              style: AppTextStyles.font16BrownPoppins400W1Height1Ov6,
            ),
            verticalSpace(24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
                onReturnHome();
              },
              child: Container(
                height: 56.h,
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                decoration: BoxDecoration(
                  gradient: AppColors.buttonGradient,
                  borderRadius: BorderRadius.circular(18.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'Return to Home',
                      style: AppTextStyles.font14BrownPoppins600W,
                    ),
                    Icon(
                      Icons.arrow_forward_rounded,
                      color: AppColors.brownText,
                      size: 22.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
