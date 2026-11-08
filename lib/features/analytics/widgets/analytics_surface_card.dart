import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AnalyticsSurfaceCard extends StatelessWidget {
  const AnalyticsSurfaceCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.border,
    this.radius,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final BoxBorder? border;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color ?? AppColors.fieldFill,
        borderRadius: BorderRadius.circular(radius ?? 24.r),
        border: border,
      ),
      child: child,
    );
  }
}
