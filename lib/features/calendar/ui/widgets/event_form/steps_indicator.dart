import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

/// Little progress bars under the header (orange = done / current).
class StepsIndicator extends StatelessWidget {
  const StepsIndicator({super.key, required this.current, required this.total});

  final int current;
  final int total;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < total; i++)
          Container(
            width: 34.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(horizontal: 2.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: i < current
                  ? AppColors.lightPeachText
                  : AppColors.pastelPeriwinkle.withOpacity(.6),
            ),
          ),
      ],
    );
  }
}
