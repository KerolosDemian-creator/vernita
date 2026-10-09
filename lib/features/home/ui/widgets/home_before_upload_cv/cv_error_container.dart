
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/home/logic/cv_rules.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/logic/cv_upload_state.dart';

class CvErrorContainer extends StatelessWidget {
  final HomeCvError error;

  const CvErrorContainer({
    super.key,
    required this.error,
  });

  String _formatSize(int bytes) {
    final mb = bytes / (1024 * 1024);

    if (mb >= 1) {
      return '${mb.toStringAsFixed(1)} MB';
    }

    return '${(bytes / 1024).toStringAsFixed(0)} KB';
  }

  @override
  Widget build(BuildContext context) {
    final fileName = error.fileName;
    final sizeInBytes = error.sizeInBytes;

    return Container(
      width: double.infinity,
      height: 290.h,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(
          color: AppColors.warmPeach,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.brownText.withOpacity(0.05),
            blurRadius: 16.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 48.r,
            height: 48.r,
            decoration: BoxDecoration(
              color: AppColors.warmPeach,
              borderRadius: BorderRadius.circular(17.r),
            ),
            child: Icon(
              Icons.file_download_off_outlined,
              color: AppColors.wrongAlert,
              size: 26.r,
            ),
          ),

          verticalSpace(8),

          Text(
            'Unable to Upload CV',
            style: AppTextStyles.font14BrownPoppins600W,
            textAlign: TextAlign.center,
          ),

          verticalSpace(4),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              error.message,
              style: AppTextStyles.font12GreyPoppins400W,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          if (fileName != null) ...[
            verticalSpace(8),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: 10.w,
                vertical: 7.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.warmCream,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.insert_drive_file_outlined,
                    color: AppColors.lightPeachText,
                    size: 22.r,
                  ),
                  horizantalSpace(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font12GreyPoppins400W.copyWith(
                            color: AppColors.brownText,
                          ),
                        ),
                        if (sizeInBytes != null)
                          Text(
                            _formatSize(sizeInBytes),
                            style: AppTextStyles.font12GreyPoppins400W,
                          ),
                      ],
                    ),
                  ),
                  if (sizeInBytes != null &&
                      sizeInBytes > CvRules.maxSizeInBytes)
                    Icon(
                      Icons.error_outline,
                      color: AppColors.wrongAlert,
                      size: 20.r,
                    ),
                ],
              ),
            ),
          ],

          verticalSpace(10),

          // Try again button.
          SizedBox(
            width: double.infinity,
            height: 40.h,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: AppColors.buttonGradient,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(14.r),
                  onTap: () => context.read<CvUploadCubit>().pickCv(),
                  child: Center(
                    child: Text(
                      'Choose Another File',
                      style: AppTextStyles.font14BrownPoppins600W.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          verticalSpace(4),

          // Cancel returns to the original upload container.
          SizedBox(
            height: 26.h,
            child: TextButton(
              onPressed: () => context.read<CvUploadCubit>().removeCv(),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.brownText,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Cancel',
                style: AppTextStyles.font12GreyPoppins400W.copyWith(
                  color: AppColors.brownText,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}