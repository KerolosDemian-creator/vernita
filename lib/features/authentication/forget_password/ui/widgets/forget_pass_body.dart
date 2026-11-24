import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/widgets/auth_bg.dart';
import 'package:vernita/features/authentication/widgets/auth_error_dialog.dart';
import 'package:vernita/features/authentication/widgets/auth_loading_dialog.dart';

import '../../logic/forget_pass_cubit.dart';
import '../../logic/forget_pass_state.dart';
import 'forget_pass_footer.dart';
import 'forget_pass_form.dart';
import 'forget_pass_header.dart';
import 'secure_card.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPassCubit, ForgetPassState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == ForgetPassStatus.loading ||
              current.status == ForgetPassStatus.failure ||
              current.status == ForgetPassStatus.success),
      listener: (context, state) {
        switch (state.status) {
          case ForgetPassStatus.loading:
            showAuthLoadingDialog(context);
          case ForgetPassStatus.failure:
            context.pop();
            showDialog(
              context: context,
              builder: (_) => AuthErrorDialog(
                title: 'Reset Request Failed',
                message: state.message ?? defaultErrorMessage,
              ),
            );
          case ForgetPassStatus.success:
            context.pop();
            final email =
                state.email ??
                context.read<ForgetPassCubit>().emailController.text.trim();
            Navigator.pushNamed(
              context,
              Routes.resetPassword,
              arguments: email,
            );
          case ForgetPassStatus.initial:
            break;
        }
      },
      child: AuthBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ForgetPassHeader(),
            SizedBox(height: 24.h),
            const ForgetPassForm(),
            SizedBox(height: 12.h),
            const SecureCard(),
            SizedBox(height: 16.h),
            const ForgetPassFooter(),
          ],
        ),
      ),
    );
  }
}
