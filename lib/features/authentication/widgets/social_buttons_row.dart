import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({
    super.key,
    this.onApplePressed,
    this.onGooglePressed,
  });

  final VoidCallback? onApplePressed;
  final VoidCallback? onGooglePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          label: 'Apple',
          icon: Icon(Icons.apple, size: 22.r, color: AppColors.brownText),
          onTap: onApplePressed,
        ),
        SizedBox(width: 30.w),
        _SocialButton(
          label: 'Google',
          icon: SizedBox(
            width: 20.r,
            height: 20.r,
            child: Center(child: SvgPicture.asset(AppSvgs.googleIcon)),
          ),
          onTap: onGooglePressed,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.icon, this.onTap});

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 119.w,
        height: 52.h,
        decoration: BoxDecoration(
          color: AppColors.fieldFill,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 12.w),
            Text(label, style: AppTextStyles.font14BrownPoppins600W),
          ],
        ),
      ),
    );
  }
}

