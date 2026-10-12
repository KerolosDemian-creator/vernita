import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/routes.dart';
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

class SignUpBody extends StatefulWidget {
  const SignUpBody({super.key});

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _agreed = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthHeader(
            title: 'Sign Up',
            subtitle: Text(
              "Let's get you started.",
              style: AppTextStyles.subtitle(),
            ),
            badge: AuthBadge.profile(),
          ),
          SizedBox(height: 22.h),
          AuthTabSwitcher(
            selected: AuthTab.signUp,
            onLogInTap: () =>
                Navigator.pushReplacementNamed(context, Routes.logIn),
          ),
          SizedBox(height: 14.h),
          AuthTextField(
            hint: 'Full name',
            icon: Icons.person_outline_rounded,
            controller: _nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Phone number',
            icon: Icons.phone_outlined,
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Create password',
            icon: Icons.lock_outline_rounded,
            controller: _passwordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Confirm password',
            icon: Icons.lock_outline_rounded,
            controller: _confirmPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
            child: Row(
              children: [
                AuthCheckbox(
                  value: _agreed,
                  onChanged: (v) => setState(() => _agreed = v),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      style: AppTextStyles.body,
                      children: [
                        const TextSpan(text: 'I agree to the '),
                        TextSpan(
                          text: 'Terms of Service',
                          style: AppTextStyles.link,
                        ),
                        const TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: AppTextStyles.link,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          AuthPrimaryButton(
            label: 'Create Account',
            // TODO: connect to sign-up logic. For now goes to Home.
            onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
              (route) => false,
            ),
          ),
          SizedBox(height: 14.h),
          const AuthDivider(label: 'or sign up with'),
          SizedBox(height: 18.h),
          const SocialButtonsRow(),
        ],
      ),
    );
  }
}
