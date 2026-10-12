import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_bg.dart';
import 'package:vernita/features/authentication/widgets/auth_badge.dart';
import 'package:vernita/features/authentication/widgets/auth_checkbox.dart';
import 'package:vernita/features/authentication/widgets/auth_divider.dart';
import 'package:vernita/features/authentication/widgets/auth_header.dart';
import 'package:vernita/features/authentication/widgets/auth_primary_button.dart';
import 'package:vernita/features/authentication/widgets/auth_tab_switcher.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';
import 'package:vernita/features/authentication/widgets/social_buttons_row.dart';

class LogInBody extends StatefulWidget {
  const LogInBody({super.key});

  @override
  State<LogInBody> createState() => _LogInBodyState();
}

class _LogInBodyState extends State<LogInBody> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthHeader(
            title: 'Sign In',
            subtitle: Text.rich(
              TextSpan(
                style: AppTextStyles.subtitle(size: 14),
                children: [
                  TextSpan(
                    text: 'Welcome back! ',
                    style: TextStyle(color: AppColors.primary),
                  ),
                  const TextSpan(text: "Let's get you signed in."),
                ],
              ),
            ),
            badge: AuthBadge.lock(),
          ),
          SizedBox(height: 22.h),
          AuthTabSwitcher(
            selected: AuthTab.logIn,
            onSignUpTap: () =>
                Navigator.pushReplacementNamed(context, Routes.signUp),
          ),
          SizedBox(height: 14.h),
          AuthTextField(
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Password',
            icon: Icons.lock_outline_rounded,
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              AuthCheckbox(
                value: _rememberMe,
                onChanged: (v) => setState(() => _rememberMe = v),
              ),
              SizedBox(width: 10.w),
              Text(
                'Remember me',
                style: AppTextStyles.body.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () =>
                    Navigator.pushNamed(context, Routes.forgotPassword),
                child: Text(
                  'Forgot password?',
                  style: AppTextStyles.link.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          AuthPrimaryButton(
            label: 'Login',
            // TODO: connect to login logic. For now goes to Home.
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            ),
          ),
          SizedBox(height: 14.h),
          const AuthDivider(label: 'or continue with'),
          SizedBox(height: 18.h),
          const SocialButtonsRow(),
          SizedBox(height: 18.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ", style: AppTextStyles.body),
              GestureDetector(
                onTap: () =>
                    Navigator.pushReplacementNamed(context, Routes.signUp),
                child: Text(
                  'Sign Up',
                  style: AppTextStyles.link.copyWith(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
