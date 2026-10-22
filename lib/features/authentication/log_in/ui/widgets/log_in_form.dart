import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/routing/routes.dart';
import '../../../widgets/auth_email_field.dart';
import '../../../widgets/auth_password_field.dart';
import '../../logic/log_in_cubit.dart';
import '../../logic/log_in_state.dart';
import 'log_in_submit_button.dart';
import 'remember_forgot_row.dart';

/// Email + password + remember me + login button.
class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthEmailField(controller: _emailController),
        SizedBox(height: 8.h),
        AuthPasswordField(
          controller: _passwordController,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 14.h),
        BlocBuilder<LogInCubit, LogInState>(
          buildWhen: (p, c) => p.rememberMe != c.rememberMe,
          builder: (context, state) => RememberForgotRow(
            rememberMe: state.rememberMe,
            onRememberChanged: context.read<LogInCubit>().toggleRememberMe,
            onForgotTap: () =>
                Navigator.pushNamed(context, Routes.forgotPassword),
          ),
        ),
        SizedBox(height: 14.h),
        LogInSubmitButton(
          emailController: _emailController,
          passwordController: _passwordController,
        ),
      ],
    );
  }
}
