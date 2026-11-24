import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../widgets/auth_bg.dart';
import '../../widgets/auth_social_section.dart';
import '../../widgets/auth_tab_switcher.dart';
import 'widgets/sign_up_form.dart';
import 'widgets/sign_up_header.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SignUpHeader(),
          SizedBox(height: 22.h),
          AuthTabSwitcher(
            selected: AuthTab.signUp,
            onLogInTap: () =>
                Navigator.pushReplacementNamed(context, Routes.logIn),
          ),
          SizedBox(height: 14.h),
          SignUpForm(),
          SizedBox(height: 14.h),
          const AuthSocialSection(dividerLabel: 'or sign up with'),
        ],
      ),
    );
  }
}
