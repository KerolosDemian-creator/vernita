import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/icon_box.dart';

/// One password input: icon, small label, dots and a show/hide eye.
class PasswordRow extends StatelessWidget {
  const PasswordRow({
    super.key,
    required this.icon,
    required this.label,
    required this.controller,
    required this.obscure,
    required this.onToggle,
  });

  final IconData icon;
  final String label;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          IconBox(icon: icon),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTextStyles.font13BrownPoppins600W.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                TextField(
                  controller: controller,
                  obscureText: obscure,
                  style: AppTextStyles.font13BrownPoppins600W,
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    filled: false,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: '\u2022\u2022\u2022\u2022\u2022\u2022\u2022\u2022',
                    hintStyle: AppTextStyles.font13BrownPoppins600W.copyWith(
                      color: AppColors.textFieldText,
                    ),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              size: 18.r,
              color: AppColors.nonSelectedIcon,
            ),
          ),
        ],
      ),
    );
  }
}
