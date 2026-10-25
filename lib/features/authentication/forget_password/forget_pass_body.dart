import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_bg.dart';
import 'package:vernita/features/authentication/widgets/auth_badge.dart';
import 'package:vernita/features/authentication/widgets/auth_divider.dart';
import 'package:vernita/features/authentication/widgets/auth_header.dart';
import 'package:vernita/features/authentication/widgets/auth_primary_button.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';

class ForgotPasswordBody extends StatefulWidget {
  const ForgotPasswordBody({super.key});

  @override
  State<ForgotPasswordBody> createState() => _ForgotPasswordBodyState();
}

class _ForgotPasswordBodyState extends State<ForgotPasswordBody> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthHeader(
            titleSize: 30,
            title: 'Forgot\nPassword?',
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.maybePop(context),
              child: Icon(
                Icons.arrow_back_rounded,
                size: 20.r,
                color: AppColors.nonSelectedIcon,
              ),
            ),
            subtitle: Text(
              "No worries! Enter your email and we'll send you a reset link.",
              style: AppTextStyles.test,
            ),
            badge: AuthBadge.lockWithQuestion(),
          ),
          SizedBox(height: 24.h),
          AuthTextField(
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 8.h),
          AuthPrimaryButton(
            label: 'Send Reset Link',
            // TODO: connect to reset-password logic.
            onPressed: () {},
          ),
          SizedBox(height: 12.h),
          const _SecureCard(),
          SizedBox(height: 16.h),
          const AuthDivider(label: 'Remember your password?'),
          SizedBox(height: 14.h),
          AuthPrimaryButton(
            label: 'Back to Login',
            showArrow: false,
            onPressed: () => Navigator.maybePop(context),
          ),
        ],
      ),
    );
  }
}

class _SecureCard extends StatelessWidget {
  const _SecureCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: AppColors.selectedIcon,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.verified_user_rounded,
              size: 19.r,
              color: AppColors.lightPeachText,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Secure & Safe',
                  style: AppTextStyles.test.copyWith(
                    color: AppColors.brownText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  "We'll never share your email with anyone else.",
                  style: AppTextStyles.test.copyWith(fontSize: 11.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
