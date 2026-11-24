import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/features/authentication/logic/auth_rules.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';

import '../../../widgets/auth_primary_button.dart';
import '../../logic/forget_pass_cubit.dart';
import '../../logic/forget_pass_state.dart';

class ForgetPassForm extends StatelessWidget {
  const ForgetPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPassCubit>();

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
            textInputAction: TextInputAction.done,
            validator: (value) => AuthRules.email(value ?? ''),
          ),
          SizedBox(height: 8.h),
          BlocBuilder<ForgetPassCubit, ForgetPassState>(
            buildWhen: (previous, current) => previous.status != current.status,
            builder: (context, state) => AuthPrimaryButton(
              label: 'Send Reset Code',
              onPressed: state.status == ForgetPassStatus.loading
                  ? null
                  : () => _submit(context),
            ),
          ),
        ],
      ),
    );
  }

  void _submit(BuildContext context) {
    final cubit = context.read<ForgetPassCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.sendResetCode();
    }
  }
}
