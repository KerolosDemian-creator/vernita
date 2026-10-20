import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// Orange gradient button (same look as the auth primary button, no arrow).
class ProfileGradientButton extends StatelessWidget {
  const ProfileGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(18.r);
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: const LinearGradient(
          begin: Alignment(-1, -0.3),
          end: Alignment(1, 0.3),
          colors: [AppColors.primary, AppColors.peach],
        ),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonShadow,
            offset: Offset(0, 8),
            blurRadius: 20,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onPressed,
          child: Center(
            child: Text(label, style: AppTextStyles.font16BrownPoppins600W),
          ),
        ),
      ),
    );
  }
}
