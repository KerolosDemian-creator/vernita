import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

/// Fonts used in the design: Poppins + Plus Jakarta Sans.
/// Make sure both are declared in pubspec.yaml (family names must match).
abstract final class AppTextStyles {
  static const String poppins = 'Poppins';
  static const String jakarta = 'PlusJakartaSans';

  static TextStyle title({double size = 40}) => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w700,
        fontSize: size.sp,
        height: 42.5 / 40,
        letterSpacing: -0.85,
        color: AppColors.brownText,
      );

  static TextStyle subtitle({double size = 16}) => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w600,
        fontSize: size.sp,
        height: 21 / 16,
        color: AppColors.lightBrownText,
      );

  static TextStyle get tab => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w700,
        fontSize: 12.sp,
        height: 16 / 12,
        color: AppColors.brownText,
      );

  static TextStyle get fieldText => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: AppColors.brownText,
      );

  static TextStyle get fieldHint => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
        color: AppColors.textFieldText,
      );

  static TextStyle get button => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w600,
        fontSize: 16.sp,
        height: 23.25 / 16,
        color: AppColors.brownText,
      );

  static TextStyle get body => TextStyle(
        fontFamily: jakarta,
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        height: 17.88 / 13,
        color: AppColors.lightBrownText,
      );

  static TextStyle get link => TextStyle(
        fontFamily: jakarta,
        fontWeight: FontWeight.w700,
        fontSize: 13.sp,
        height: 17.88 / 13,
        color: AppColors.primary,
      );

  static TextStyle get social => TextStyle(
        fontFamily: jakarta,
        fontWeight: FontWeight.w700,
        fontSize: 14.sp,
        height: 21 / 14,
        color: AppColors.brownText,
      );

  static TextStyle get divider => TextStyle(
        fontFamily: poppins,
        fontWeight: FontWeight.w400,
        fontSize: 13.sp,
        height: 16 / 13,
        letterSpacing: -0.3,
        color: AppColors.lightBrownText,
      );
}
