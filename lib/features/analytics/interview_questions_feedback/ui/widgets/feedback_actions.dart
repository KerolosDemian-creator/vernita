import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class FeedbackActions extends StatelessWidget {
  const FeedbackActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: _ActionButton(
                icon: Icons.ios_share_rounded,
                label: 'Share Feedback',
              ),
            ),
            horizantalSpace(10),
            const Expanded(
              child: _ActionButton(
                icon: Icons.file_download_outlined,
                label: 'Download PDF',
              ),
            ),
          ],
        ),
        verticalSpace(10),
        Container(
          width: double.infinity,
          height: 48.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppColors.buttonGradient,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Text(
            'Practice Similar Questions',
            style: AppTextStyles.font13BrownPoppins500W.copyWith(
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.brownText,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.analyticsDivider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15.r, color: AppColors.lightBrown),
          horizantalSpace(6),
          Text(
            label,
            style: AppTextStyles.font11GreyPoppins400W.copyWith(
              color: AppColors.lightBrown,
              fontWeight: FontWeight.w600,
              fontSize: 11.sp,
            ),
          ),
        ],
      ),
    );
  }
}
