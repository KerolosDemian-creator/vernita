import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AppTextStyles {
  // Poppins
  static TextStyle test = TextStyle(
    fontSize: 10.sp,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    color: AppColors.oliveForest,
  );
  static TextStyle font10OliverForestPopppins700W = TextStyle(
    fontSize: 10.sp,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
    color: AppColors.oliveForest,
  );
  static TextStyle font10LightBrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.lightBrown,
  );
  static TextStyle font11GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 11.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );
  static TextStyle font12GreyPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.greyText,
  );
  static TextStyle font12BrowPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
  static TextStyle font12BrowPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
    letterSpacing: 1.4,
  );
  static TextStyle font12BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );
  static TextStyle font12LightBrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.lightBrown,
  );
  static TextStyle font13LightPeachPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.lightPeachText,
  );
  static TextStyle font13LightPeachPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.lightPeachText,
  );

  static TextStyle font13LightPeachPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.lightPeachText,
  );
  static TextStyle font13LightBrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.lightBrown,
  );

  static TextStyle font14BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );
  static TextStyle font14BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );

  static TextStyle font15BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );

  static TextStyle font14LightPeachPoppins400W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.lightPeachText,
  );

  static TextStyle font16BrownPoppins400W1Height1Ov6 = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: AppColors.brownText,
  );

  static TextStyle font18BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 15.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
  static TextStyle font20BrownPoppins600W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.brownText,
  );
  static TextStyle font20BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 20.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
  static TextStyle font22BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 22.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
  static TextStyle font26BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
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
    color: AppColors.lightPeachText,
  );

  /// Tab switcher (Sign In | Sign Up).
  static TextStyle font12BrownPoppins700W = TextStyle(
    fontFamily: AppFonts.poppins,
    fontSize: 12.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.brownText,
  );
}
