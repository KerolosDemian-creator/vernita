import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class QuestionFeedbackItem extends StatelessWidget {
  const QuestionFeedbackItem({
    super.key,
    required this.number,
    required this.question,
    required this.isStrong,
    required this.timing,
    required this.feedbackTitle,
    required this.feedback,
    required this.onTap,
  });

  final String number;
  final String question;
  final bool isStrong;
  final String timing;
  final String feedbackTitle;
  final String feedback;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = isStrong
        ? AppColors.positiveGreen
        : AppColors.wrongAlert;

    return Semantics(
      button: true,
      label: 'Open feedback for $question',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(18.r),
            border: Border.all(color: AppColors.analyticsDivider),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: isStrong
                          ? AppColors.positiveGreenSurface
                          : AppColors.paleApricot,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      number,
                      style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                        color: isStrong
                            ? AppColors.positiveGreen
                            : AppColors.lightPeachText,
                        fontWeight: FontWeight.w700,
                        fontSize: 11.sp,
                      ),
                    ),
                  ),
                  horizantalSpace(10),
                  Expanded(
                    child: Text(
                      question,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.font14BrownPoppins700W.copyWith(
                        height: 1.25,
                      ),
                    ),
                  ),
                  horizantalSpace(4),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.brownText,
                    size: 20.r,
                  ),
                ],
              ),
              verticalSpace(9),

              // Question Status
              Container(
                padding: isStrong
                    ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isStrong
                      ? AppColors.positiveGreenSurface
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isStrong ? 'STRONG ANSWER' : 'NEEDS POLISHING',
                      style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                        color: statusColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.15,
                      ),
                    ),
                    horizantalSpace(5),
                    Container(
                      width: 3.r,
                      height: 3.r,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    horizantalSpace(5),
                    Icon(
                      Icons.schedule_rounded,
                      size: 11.r,
                      color: statusColor,
                    ),
                    horizantalSpace(2),
                    Text(
                      timing,
                      style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                        color: statusColor,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(12),

              // Feedback
              if (isStrong)
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.positiveGreenSurface,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.positiveGreen.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.check_circle_rounded,
                            size: 14.r,
                            color: AppColors.lightPeachText,
                          ),
                          horizantalSpace(5),
                          Expanded(
                            child: Text(
                              feedbackTitle,
                              style: AppTextStyles.font10LightBrownPoppins600W
                                  .copyWith(
                                    color: AppColors.lightPeachText,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 11.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      verticalSpace(4),
                      Text(
                        feedback,
                        style: AppTextStyles.font12BrownPoppins600W.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.lightBrown,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline_rounded,
                          size: 15.r,
                          color: AppColors.lightPeachText,
                        ),
                        horizantalSpace(5),
                        Expanded(
                          child: Text(
                            feedbackTitle,
                            style: AppTextStyles.font10LightBrownPoppins600W
                                .copyWith(
                                  color: AppColors.lightPeachText,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 11.sp,
                                ),
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(4),
                    Text(
                      feedback,
                      style: AppTextStyles.font12BrownPoppins600W.copyWith(
                        fontWeight: FontWeight.w400,
                        color: AppColors.lightBrown,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
