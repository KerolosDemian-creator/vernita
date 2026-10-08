import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class YourDataIsSecureTxt extends StatelessWidget {
  const YourDataIsSecureTxt({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppSvgs.securityIcon),
          horizantalSpace(15),
          Expanded(
            child: Text(
              'Your data is secure and will only be used to improve your experience.',
              maxLines: 2,
              style: AppTextStyles.font12GreyPoppins400W,
            ),
          ),
        ],
      ),
    );
  }
}
