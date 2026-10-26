import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/errors/api_error_handler.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_cubit.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_state.dart';
import 'package:vernita/features/authentication/widgets/auth_error_dialog.dart';

class LogInListener extends StatelessWidget {
  const LogInListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogInCubit, LogInState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == LogInStatus.loading ||
              current.status == LogInStatus.failure ||
              current.status == LogInStatus.success),
      listener: (context, state) {
        switch (state.status) {
          case LogInStatus.loading:
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightPeachText,
                ),
              ),
            );
          case LogInStatus.failure:
            setupErrorState(context, state.errorMessage ?? defaultErrorMessage);
          case LogInStatus.success:
            context.pop();
            context.pushReplacementNamed(Routes.main);
          case LogInStatus.initial:
            break;
        }
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String errMessage) {
    context.pop();
    showDialog(
      context: context,
      builder: (_) =>
          AuthErrorDialog(title: 'Login Failed', message: errMessage),
    );
  }
}
