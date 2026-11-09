import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.onTap,
    this.label = 'Choose file',
    this.icon = Icons.file_upload_outlined,
    this.isEnabled = true,
    this.margin,
  });

  final VoidCallback onTap;
  final String label;
  final IconData icon;
  final bool isEnabled;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnabled ? onTap : null,
        child: Container(
          height: 50.h,
          margin: margin ?? EdgeInsets.symmetric(horizontal: 27.w),
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: AppColors.brownText),
              horizantalSpace(4),
              Text(label, style: AppTextStyles.font16BrownInter600W),
            ],
          ),
        ),
      ),
    );
  }
}
