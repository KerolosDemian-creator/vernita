import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class QuestionFeedbackHeader extends StatelessWidget {
  const QuestionFeedbackHeader({
    super.key,
    required this.number,
    required this.question,
    required this.score,
    required this.maxScore,
    required this.isExpanded,
    required this.numberColor,
    required this.scoreColor,
  });

  final int number;
  final String question;
  final int score;
  final int maxScore;
  final bool isExpanded;

  final Color numberColor;
  final Color scoreColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$number',
          style: AppTextStyles.font14BrownPoppins700W.copyWith(
            fontSize: 15.sp,
            color: numberColor,
          ),
        ),

        horizantalSpace(12),

        Expanded(
          child: Text(
            question,
            maxLines: isExpanded ? 3 : 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.font14BrownPoppins700W.copyWith(
              fontSize: 14.sp,
              height: 1.25,
            ),
          ),
        ),

        horizantalSpace(6),

        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Score',
              style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                color: AppColors.lightBrown,
                fontWeight: FontWeight.w400,
                fontSize: 9.sp,
              ),
            ),

            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$score',
                    style: AppTextStyles.font14BrownPoppins700W.copyWith(
                      fontSize: 14.sp,
                      color: scoreColor,
                    ),
                  ),

                  TextSpan(
                    text: '/$maxScore',
                    style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                      color: AppColors.lightBrown,
                      fontSize: 9.5.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        horizantalSpace(2),

        Icon(
          isExpanded
              ? Icons.keyboard_arrow_up_rounded
              : Icons.keyboard_arrow_down_rounded,
          color: AppColors.lightBrown,
          size: 20.r,
        ),
      ],
    );
  }
}