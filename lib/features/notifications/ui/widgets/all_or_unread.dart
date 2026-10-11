import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AllOrUnread extends StatelessWidget {
  const AllOrUnread({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Text('All', style: AppTextStyles.font13LightPeachPoppins700W),
        ),
        horizantalSpace(30),
        Text('Unread', style: AppTextStyles.font13LightBrownPoppins700W),
      ],
    );
  }
}
