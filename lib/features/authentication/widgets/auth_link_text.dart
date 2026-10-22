import 'package:flutter/material.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// Underlined orange tappable text ("Forgot password?", "Sign Up", ...).
class AuthLinkText extends StatelessWidget {
  const AuthLinkText({super.key, required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        style: AppTextStyles.font13PrimaryPoppins700W.copyWith(
          decoration: TextDecoration.underline,
          decorationColor: AppColors.lightPeachText,
        ),
      ),
    );
  }
}
