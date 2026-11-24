import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// Orange gradient button. Set [showArrow] for "Add Task →".
class AppGradientButton extends StatelessWidget {
  const AppGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.showArrow = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;

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
          colors: [AppColors.lightPeachText, AppColors.peach],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(label, style: AppTextStyles.font16BrownPoppins600W),
              if (showArrow) ...[
                horizantalSpace(8),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 18.r,
                  color: AppColors.brownText,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
