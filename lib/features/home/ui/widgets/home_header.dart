import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back 👋',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              'Alex Mercer',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Spacer(),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.r),
            color: Colors.red,
          ),
          child: SvgPicture.asset(AppSvgs.notficationsIcon),
        ),
      ],
    );
  }
}
