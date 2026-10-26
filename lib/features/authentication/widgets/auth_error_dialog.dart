import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_primary_button.dart';

/// Shared error dialog for the authentication flow.
class AuthErrorDialog extends StatelessWidget {
  const AuthErrorDialog({
    super.key,
    required this.title,
    required this.message,
  });

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 52.w, vertical: 24.h),
      child: Container(
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 22.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: AppColors.warmPeach),
          boxShadow: [
            BoxShadow(
              color: AppColors.fieldShadow,
              blurRadius: 24.r,
              offset: Offset(0, 12.h),
            ),
          ],
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.75,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 54.r,
                  height: 54.r,
                  decoration: BoxDecoration(
                    color: AppColors.softBlush,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    color: AppColors.terracottaRed,
                    size: 27.r,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.font20BrownPoppins600W,
              ),
              SizedBox(height: 6.h),
              Flexible(
                child: SingleChildScrollView(
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.font13BrownPoppins500W.copyWith(
                      color: AppColors.lightBrownText,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              AuthPrimaryButton(
                label: 'Got it',
                showArrow: false,
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
