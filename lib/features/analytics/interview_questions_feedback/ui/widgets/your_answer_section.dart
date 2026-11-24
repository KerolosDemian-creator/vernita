import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class YourAnswerSection extends StatelessWidget {
  const YourAnswerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.person_outline_rounded,
              size: 15.r,
              color: AppColors.lightBrown,
            ),
            horizantalSpace(5),
            Text(
              'Your Answer',
              style: AppTextStyles.font12BrownPoppins600W.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        verticalSpace(8),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.analyticsDivider),
          ),
          child: Text(
            'I would design the chat application using a scalable backend '
            'with WebSockets for real-time communication. I would use a load '
            'balancer to distribute incoming requests across multiple servers, '
            'and a database to store messages and user information. I would also '
            'consider caching frequently accessed data and using message queues '
            'to handle high traffic efficiently.',
            style: AppTextStyles.font11GreyPoppins400W.copyWith(
              color: AppColors.lightBrown,
              fontSize: 10.5.sp,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
