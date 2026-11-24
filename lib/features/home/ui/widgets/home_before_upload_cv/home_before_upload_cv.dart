import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/cv_listener.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/tips_for_cv_container.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/your_data_is_secure_txt.dart';

class HomeBeforeUploadCv extends StatelessWidget {
  const HomeBeforeUploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          verticalSpace(50),
          const CvListener(),
          verticalSpace(13),
          const YourDataIsSecureTxt(),
          verticalSpace(35),

          const TipsForCvContainer(),
        ],
      ),
    );
  }
}
