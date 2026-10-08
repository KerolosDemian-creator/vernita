import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_button.dart';

class UploadCvContainer extends StatelessWidget {
  const UploadCvContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 270.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Icon(Icons.upload_file_outlined, color: Colors.white),
            ),
            verticalSpace(24),

            Text('Drag & drop your CV here'),
            Text('PDF, DOC, DOCX (Max. 10MB)'),
            verticalSpace(32),

            AppButton(),
          ],
        ),
      ),
    );
  }
}
