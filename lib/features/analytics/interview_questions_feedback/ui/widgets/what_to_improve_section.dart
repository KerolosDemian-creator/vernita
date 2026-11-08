import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class WhatToImproveSection extends StatelessWidget {
  const WhatToImproveSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 14.r,
              color: AppColors.wrongAlert,
            ),
            horizantalSpace(5),
            Text(
              'What to Improve',
              style: AppTextStyles.font12BrownPoppins600W.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),

        verticalSpace(6),
        _ImprovementBulletItem(
          text: 'Explain database choices and sharding strategy',
        ),

        verticalSpace(4),
        _ImprovementBulletItem(
          text: 'Discuss message delivery (sent, delivered, read)',
        ),

        verticalSpace(4),
        _ImprovementBulletItem(
          text: 'Mention offline support and sync mechanism',
        ),
      ],
    );
  }
}

class _ImprovementBulletItem extends StatelessWidget {
  const _ImprovementBulletItem({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Container(
              width: 5.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: AppColors.wrongAlert,
                shape: BoxShape.circle,
              ),
            ),
          ),
          horizantalSpace(8),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.font12BrownPoppins600W.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.lightBrown,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
