import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AnalyticsScoreBar extends StatelessWidget {
  const AnalyticsScoreBar({
    super.key,
    required this.value,
    required this.color,
    this.height,
    this.backgroundColor,
  });

  final double value;
  final Color color;
  final double? height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final progress = value.clamp(0.0, 1.0).toDouble();

    return ClipRRect(
      borderRadius: BorderRadius.circular(50.r),
      child: LinearProgressIndicator(
        value: progress,
        minHeight: height ?? 6.h,
        backgroundColor: backgroundColor ?? AppColors.paleApricot,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }
}
