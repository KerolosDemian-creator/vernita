import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: AppColors.nonSelectedIcon,
                ),
              ),
            ),
            horizantalSpace(6),
            Text('Notifications', style: AppTextStyles.font20BrownPoppins700W),
          ],
        ),
        Spacer(),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.softApricot,
            borderRadius: BorderRadius.circular(22.r),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                size: 17,
                color: AppColors.lightPeachText,
              ),
              horizantalSpace(6),
              Text(
                'Read All',
                style: AppTextStyles.font13LightPeachPoppins700W,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
