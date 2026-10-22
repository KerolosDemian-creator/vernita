import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AuthPrimaryButton extends StatelessWidget {
  const AuthPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.showArrow = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(22.r);

    return Container(
      height: 58.h,
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
            offset: Offset(0, 10),
            blurRadius: 25,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: showArrow ? 28.w : 0),
                child: Text(label, style: AppTextStyles.font16BrownPoppins600W),
              ),
              if (showArrow)
                Positioned(
                  right: 26.w,
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    size: 20.r,
                    color: AppColors.brownText,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
