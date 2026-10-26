import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/widgets/auth_bg.dart';
import 'package:vernita/features/authentication/widgets/auth_error_dialog.dart';
import 'package:vernita/features/authentication/widgets/auth_loading_dialog.dart';
import 'package:vernita/features/authentication/widgets/auth_snack_bar.dart';

import '../../logic/reset_pass_cubit.dart';
import '../../logic/reset_pass_state.dart';
import 'reset_pass_footer.dart';
import 'reset_pass_form.dart';
import 'reset_pass_header.dart';

class ResetPassBody extends StatelessWidget {
  const ResetPassBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPassCubit, ResetPassState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == ResetPassStatus.loading ||
              current.status == ResetPassStatus.failure ||
              current.status == ResetPassStatus.success),
      listener: (context, state) {
        switch (state.status) {
          case ResetPassStatus.loading:
            showAuthLoadingDialog(context);
          case ResetPassStatus.failure:
            context.pop();
            showDialog(
              context: context,
              builder: (_) => AuthErrorDialog(
                title: 'Reset Failed',
                message: state.message ?? defaultErrorMessage,
              ),
            );
          case ResetPassStatus.success:
            context.pop();
            showAuthSnackBar(
              context,
              state.message ?? 'Password has been reset successfully.',
            );
            context.pushNamedAndRemoveUntil(
              Routes.logIn,
              predicate: (_) => false,
            );
          case ResetPassStatus.initial:
            break;
        }
      },
      child: AuthBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ResetPassHeader(),
            SizedBox(height: 24.h),
            const ResetPassForm(),
            SizedBox(height: 16.h),
            const ResetPassFooter(),
          ],
        ),
      ),
    );
  }
}
