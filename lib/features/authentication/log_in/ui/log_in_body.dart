import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../widgets/auth_bg.dart';
import '../../widgets/auth_social_section.dart';
import '../../widgets/auth_switch_prompt.dart';
import '../../widgets/auth_tab_switcher.dart';
import 'widgets/log_in_form.dart';
import 'widgets/log_in_header.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({super.key});

  void _goToSignUp(BuildContext context) =>
      Navigator.pushReplacementNamed(context, Routes.signUp);

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogInHeader(),
          SizedBox(height: 22.h),
          AuthTabSwitcher(
            selected: AuthTab.logIn,
            onSignUpTap: () => _goToSignUp(context),
          ),
          SizedBox(height: 14.h),
          const LogInForm(),
          SizedBox(height: 14.h),
          const AuthSocialSection(dividerLabel: 'or continue with'),
          SizedBox(height: 18.h),
          AuthSwitchPrompt(
            question: "Don't have an account?",
            actionLabel: 'Sign Up',
            onTap: () => _goToSignUp(context),
          ),
        ],
      ),
    );
  }
}
