import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AppTextStyles {
  // Poppins
  static TextStyle font12GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );
  static TextStyle font13LightPeachPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.primary,
  );
  static TextStyle font13GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );

  static TextStyle font14BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );

  static TextStyle font16BrownPoppins400W1Height1Ov6 = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.brownText,
  );

  static TextStyle font20BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );
  static TextStyle font28BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 28.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );

  /// Inter
  static TextStyle font16BrownInter600W = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );

  // ================= Auth screens =================

  /// Auth title (Sign In / Sign Up). Forgot password uses copyWith(fontSize: 30.sp).
  static TextStyle font40BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 40.sp,
    fontWeight: FontWeight.w700,
    height: 42.5 / 40,
    letterSpacing: -0.85,
    color: AppColors.brownText,
  );

  /// Auth subtitle + primary button label.
  static TextStyle font16BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );

  /// Text field input.
  static TextStyle font15BrownPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.brownText,
  );

  /// Text field hint.
  static TextStyle font15GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 15.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );

  /// Body text ("Remember me", "Don't have an account?").
  static TextStyle font13BrownPoppins500W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.brownText,
  );

  /// Links ("Forgot password?", "Sign Up", "Terms of Service").
  static TextStyle font13PrimaryPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  /// Tab switcher (Sign In | Sign Up).
  static TextStyle font12BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );


    // ================= Profile / Settings / Notifications / Security =================
  static TextStyle font18BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 18.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
  static TextStyle font13BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );
  static TextStyle font11LightBrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.8,
    color: AppColors.lightBrownText,
  );
  static TextStyle font11GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );
  static TextStyle font12PrimaryPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
  static TextStyle font11SuccessPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.greenAlert,
  );
  static TextStyle font11DangerPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.wrongAlert,
  );
}
