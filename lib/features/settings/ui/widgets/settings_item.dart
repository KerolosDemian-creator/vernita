import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class SettingsItem extends StatelessWidget {
  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.value,
    this.iconBackgroundColor,
    this.trailing,
    this.showChevron = true,
    this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final Color? iconBackgroundColor;
  final String? value;
  final Widget? trailing;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 75.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: subtitle == null || iconBackgroundColor != null
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            if (iconBackgroundColor == null)
              SizedBox(
                height: 27.h,
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.nonSelectedIcon,
                    size: 22.r,
                  ),
                ),
              )
            else
              Container(
                width: 38.r,
                height: 38.r,
                decoration: BoxDecoration(
                  color: iconBackgroundColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: AppColors.nonSelectedIcon,
                    size: 22.r,
                  ),
                ),
              ),
            horizantalSpace(16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font14BrownPoppins700W,
                  ),
                  if (subtitle != null) ...[
                    verticalSpace(2),
                    Text(
                      subtitle!,
                      style: AppTextStyles.font12GreyPoppins400W.copyWith(
                        height: 1.45,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (value != null) ...[
              horizantalSpace(8),
              SizedBox(
                height: 27.h,
                child: Center(
                  child: Text(
                    value!,
                    style: AppTextStyles.font14LightPeachPoppins400W,
                  ),
                ),
              ),
            ],
            if (trailing != null) ...[horizantalSpace(8), trailing!],
            if (showChevron) ...[
              horizantalSpace(6),
              SizedBox(
                height: 27.h,
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: AppColors.nonSelectedIcon,
                    size: 12.r,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
