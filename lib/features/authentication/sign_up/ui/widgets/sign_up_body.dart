import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/routing/routes.dart';
import '../../../widgets/auth_bg.dart';
import '../../../widgets/auth_snack_bar.dart';
import '../../../widgets/auth_social_section.dart';
import '../../../widgets/auth_tab_switcher.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';
import 'sign_up_form.dart';
import 'sign_up_header.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.main,
            (route) => false,
          );
        } else if (state.status == SignUpStatus.failure) {
          showAuthSnackBar(context, state.errorMessage ?? 'Something went wrong');
        }
      },
      child: AuthBackground(
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
            const SignUpForm(),
            SizedBox(height: 14.h),
            const AuthSocialSection(dividerLabel: 'or sign up with'),
          ],
        ),
      ),
    );
  }
}
