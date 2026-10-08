import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/tips_for_cv_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/your_data_is_secure_txt.dart';
import 'package:vernita/features/home/ui/widgets/home_header.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/upload_cv_container.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            HomeHeader(),
            verticalSpace(50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  UploadCvContainer(),
                  verticalSpace(13),
                  YourDataIsSecureTxt(),
                  verticalSpace(35),

                  TipsForCvContainer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
