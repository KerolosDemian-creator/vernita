import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/start_interview_button.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/time_and_difficulty_row.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/upcoming_mock_row.dart';

class UpcomingMockContainer extends StatelessWidget {
  const UpcomingMockContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 24.h),
      height: 235.h,
      decoration: BoxDecoration(
        gradient: AppColors.upcomingMockContainerGradient,
        borderRadius: BorderRadius.circular(28.r),
      ),
      child: Column(
        children: [
          UpcomingMockRow(),
          verticalSpace(5.h),
          TimeAndDifficultyRow(),
          verticalSpace(5),
          StartInterviewButton(),
        ],
      ),
    );
  }
}
