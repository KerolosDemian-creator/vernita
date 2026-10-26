import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';

import '../../../widgets/auth_primary_button.dart';
import '../../logic/reset_pass_cubit.dart';
import '../../logic/reset_pass_state.dart';

class ResetPassForm extends StatelessWidget {
  const ResetPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPassCubit>();

    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            hint: '6-digit reset code',
            icon: Icons.pin_outlined,
            controller: cubit.codeController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            validator: (value) => AuthRules.resetCode(value ?? ''),
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'New password',
            icon: Icons.lock_outline_rounded,
            controller: cubit.passwordController,
            isPassword: true,
            textInputAction: TextInputAction.next,
            validator: (value) => AuthRules.resetPassword(value ?? ''),
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Confirm new password',
            icon: Icons.lock_outline_rounded,
            controller: cubit.confirmPasswordController,
            isPassword: true,
            textInputAction: TextInputAction.done,
            validator: (value) => AuthRules.confirmPassword(
              value ?? '',
              cubit.passwordController.text,
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<ResetPassCubit, ResetPassState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => AuthPrimaryButton(
              label: 'Reset Password',
              onPressed: state.status == ResetPassStatus.loading
                  ? null
                  : () => _submit(context),
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    final cubit = context.read<ResetPassCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.resetPassword();
    }
  }
}
