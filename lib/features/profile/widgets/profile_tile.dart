import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'icon_box.dart';

/// Generic list row: [icon box] title / subtitle ........ value / trailing / chevron.
class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    this.icon,
    required this.title,
    this.subtitle,
    this.subtitleWidget,
    this.value,
    this.trailing,
    this.showChevron = false,
    this.onTap,
    this.titleStyle,
    this.subtitleStyle,
    this.iconBackground = AppColors.selectedIcon,
    this.iconColor = AppColors.nonSelectedIcon,
  });

  final IconData? icon;
  final String title;
  final String? subtitle;

  /// Replaces [subtitle] when you need something richer than plain text.
  final Widget? subtitleWidget;

  /// Orange value shown before the chevron (e.g. "Sarah (US)").
  final String? value;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final Color iconBackground;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            if (icon != null) ...[
              IconBox(icon: icon!, background: iconBackground, color: iconColor),
              SizedBox(width: 12.w),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: titleStyle ?? AppTextStyles.font13BrownPoppins600W,
                  ),
                  if (subtitleWidget != null) ...[
                    SizedBox(height: 3.h),
                    subtitleWidget!,
                  ] else if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle!,
                      style: subtitleStyle ?? AppTextStyles.font11GreyPoppins400W,
                    ),
                  ],
                ],
              ),
            ),
            if (value != null) ...[
              SizedBox(width: 8.w),
              Text(value!, style: AppTextStyles.font12PrimaryPoppins600W),
            ],
            if (trailing != null) ...[SizedBox(width: 8.w), trailing!],
            if (showChevron) ...[
              SizedBox(width: 4.w),
              Icon(
                Icons.chevron_right_rounded,
                size: 20.r,
                color: AppColors.nonSelectedIcon,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
