import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AnalyticsStatusPill extends StatelessWidget {
  const AnalyticsStatusPill({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
    this.icon,
    this.border,
    this.padding,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(50.r),
        border: border,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 11.r, color: foreground),
            horizantalSpace(4),
          ],
          Text(
            label,
            style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
              color: foreground,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.15,
            ),
          ),
        ],
      ),
    );
  }
}
