import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';
import '../../logic/log_in_cubit.dart';
import '../../logic/log_in_state.dart';
import 'log_in_listener.dart';
import 'log_in_submit_button.dart';
import 'remember_forgot_row.dart';

class LogInForm extends StatelessWidget {
  const LogInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LogInCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            controller: cubit.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: (value) => AuthRules.email(value ?? ''),
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'password',
            icon: Icons.lock_outline_rounded,
            controller: cubit.passwordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: (value) => AuthRules.password(value ?? ''),
          ),
          SizedBox(height: 14.h),
          BlocBuilder<LogInCubit, LogInState>(
            buildWhen: (previous, current) =>
                previous.rememberMe != current.rememberMe,
            builder: (context, state) => RememberForgotRow(
              rememberMe: state.rememberMe,
              onRememberChanged: cubit.toggleRememberMe,
              onForgotTap: () =>
                  Navigator.pushNamed(context, Routes.forgotPassword),
            ),
          ),
          SizedBox(height: 14.h),
          LogInSubmitButton(),
          const LogInListener(),
        ],
      ),
    );
  }
}
