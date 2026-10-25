import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';

import '../../../widgets/auth_primary_button.dart';
import '../../logic/forget_pass_cubit.dart';
import '../../logic/forget_pass_state.dart';

class ForgetPassForm extends StatefulWidget {
  const ForgetPassForm({super.key});

  @override
  State<ForgetPassForm> createState() => _ForgetPassFormState();
}

class _ForgetPassFormState extends State<ForgetPassForm> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          hint: 'Email address',
          icon: Icons.mail_outline_rounded,
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 8.h),
        BlocBuilder<ForgetPassCubit, ForgetPassState>(
          buildWhen: (p, c) => p.status != c.status,
          builder: (context, state) => AuthPrimaryButton(
            label: 'Send Reset Link',
            onPressed: state.status == ForgetPassStatus.loading
                ? null
                : () => context.read<ForgetPassCubit>().sendResetLink(
                    _emailController.text,
                  ),
          ),
        ),
      ],
    );
  }
}
