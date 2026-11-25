import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

/// White pill used for "End-to-End Encrypted" and the recording timer.
class StatusPill extends StatelessWidget {
  const StatusPill({required this.leading, required this.label});

  final Widget leading;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          leading,
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.brownText,
            ),
          ),
        ],
      ),
    );
  }
}
