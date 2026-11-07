import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class RecentMockInterviewTile extends StatelessWidget {
  const RecentMockInterviewTile({
    super.key,
    required this.title,
    required this.date,
    required this.duration,
    required this.score,
    required this.techScore,
    required this.speechScore,
    required this.visionScore,
  });

  final String title;
  final String date;
  final String duration;
  final String score;
  final String techScore;
  final String speechScore;
  final String visionScore;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font15BrownPoppins700W.copyWith(
              fontSize: 14.sp,
            ),
          ),
          verticalSpace(3),
          Row(
            children: [
              Expanded(
                child: Text(
                  '$date  •  $duration',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12GreyPoppins400W.copyWith(
                    fontSize: 11.sp,
                  ),
                ),
              ),
              Text(
                score,
                style: AppTextStyles.font20BrownPoppins700W.copyWith(
                  fontSize: 18.sp,
                  color: AppColors.lightPeachText,
                  height: 1.1,
                ),
              ),
              horizantalSpace(2),
              Icon(
                Icons.chevron_right_rounded,
                color: AppColors.brownText,
                size: 20.r,
              ),
            ],
          ),
          verticalSpace(10),
          Wrap(
            spacing: 16.w,
            runSpacing: 4.h,
            children: [
              _ScoreLabel(
                label: 'Tech',
                value: techScore,
                color: AppColors.lightPeachText,
              ),
              _ScoreLabel(
                label: 'Speech',
                value: speechScore,
                color: AppColors.speechTeal,
              ),
              _ScoreLabel(
                label: 'Vision',
                value: visionScore,
                color: AppColors.personalTask,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreLabel extends StatelessWidget {
  const _ScoreLabel({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $value',
      style: AppTextStyles.font12BrownPoppins600W.copyWith(color: color),
    );
  }
}
