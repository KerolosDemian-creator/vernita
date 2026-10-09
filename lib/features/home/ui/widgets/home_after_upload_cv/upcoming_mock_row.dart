import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class UpcomingMockRow extends StatelessWidget {
  const UpcomingMockRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UPCOMING MOCK',
                style: AppTextStyles.font13LightPeachPoppins700W,
              ),
              verticalSpace(2),
              Text(
                'Senior Product Designer',
                style: AppTextStyles.font26BrownPoppins700W,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Container(
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: SvgPicture.asset(AppSvgs.upcomingMockCardIcon),
        ),
      ],
    );
  }
}
