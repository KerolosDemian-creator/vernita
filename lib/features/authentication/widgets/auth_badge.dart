import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// The rounded square at the top-right of each auth screen
/// (avatar for Sign Up, lock for Sign In / Forgot Password).
class AuthBadge extends StatelessWidget {
  const AuthBadge._({required this.child, this.corner});

  /// Avatar + small "+" badge (Sign Up).
  factory AuthBadge.profile() =>
      AuthBadge._(child: const _AvatarGraphic(), corner: const _PlusCorner());

  /// Lock icon (Sign In).
  factory AuthBadge.lock() => const AuthBadge._(child: _LockGraphic());

  /// Lock icon with a "?" badge (Forgot Password).
  factory AuthBadge.lockWithQuestion() =>
      const AuthBadge._(child: _LockGraphic(), corner: _QuestionCorner());

  final Widget child;
  final Widget? corner;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88.r,
      height: 88.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 88.r,
            height: 88.r,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.badgeStart, AppColors.badgeEnd],
              ),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.badgeShadow,
                  offset: Offset(0, 8),
                  blurRadius: 18,
                  spreadRadius: -4,
                ),
              ],
            ),
            child: child,
          ),
          if (corner != null) Positioned(right: -4.r, bottom: -4.r, child: corner!),
        ],
      ),
    );
  }
}

class _AvatarGraphic extends StatelessWidget {
  const _AvatarGraphic();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 27.r,
          height: 27.r,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(height: 5.h),
        Container(
          width: 52.w,
          height: 31.h,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.all(Radius.elliptical(26.w, 18.h)),
          ),
        ),
      ],
    );
  }
}

class _LockGraphic extends StatelessWidget {
  const _LockGraphic();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.lock_rounded, size: 48.r, color: AppColors.primary);
  }
}

class _PlusCorner extends StatelessWidget {
  const _PlusCorner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.r,
      height: 24.r,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.peach],
        ),
      ),
      child: Icon(Icons.add_rounded, size: 15.r, color: Colors.white),
    );
  }
}

class _QuestionCorner extends StatelessWidget {
  const _QuestionCorner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22.r,
      height: 22.r,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Text(
        '?',
        style: AppTextStyles.font13PrimaryPoppins700W.copyWith(fontSize: 12.sp),
      ),
    );
  }
}
