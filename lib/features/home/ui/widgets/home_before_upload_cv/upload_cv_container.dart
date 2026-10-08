import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_button.dart';

class UploadCvContainer extends StatelessWidget {
  const UploadCvContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 11.h),

      height: 290.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.7),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.lightRed),
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.warmPeach,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(
                Icons.upload_file_outlined,
                color: AppColors.lightPeachText,
                size: 32,
              ),
            ),
            verticalSpace(24),

            Text(
              'Drag & drop your CV here',
              style: AppTextStyles.font14BrownPoppins600W,
            ),
            verticalSpace(4),

            Text(
              'PDF, DOC, DOCX (Max. 10MB)',
              style: AppTextStyles.font12GreyPoppins400W,
            ),
            verticalSpace(32),

            AppButton(),
          ],
        ),
      ),
    );
  }
}
