import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../widgets/auth_email_field.dart';
import '../../../widgets/auth_password_field.dart';
import '../../../widgets/auth_text_field.dart';
import '../../logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';
import 'sign_up_submit_button.dart';
import 'terms_agreement_row.dart';

/// All sign-up fields + terms checkbox + create account button.
class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          hint: 'Full name',
          icon: Icons.person_outline_rounded,
          controller: _nameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 8.h),
        AuthEmailField(controller: _emailController),
        SizedBox(height: 8.h),
        AuthTextField(
          hint: 'Phone number',
          icon: Icons.phone_outlined,
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 8.h),
        AuthPasswordField(
          controller: _passwordController,
          hint: 'Create password',
        ),
        SizedBox(height: 8.h),
        AuthPasswordField(
          controller: _confirmPasswordController,
          hint: 'Confirm password',
          textInputAction: TextInputAction.done,
        ),
        SizedBox(height: 8.h),
        BlocBuilder<SignUpCubit, SignUpState>(
          buildWhen: (p, c) => p.agreed != c.agreed,
          builder: (context, state) => TermsAgreementRow(
            agreed: state.agreed,
            onChanged: context.read<SignUpCubit>().toggleAgreed,
          ),
        ),
        SizedBox(height: 8.h),
        SignUpSubmitButton(
          nameController: _nameController,
          emailController: _emailController,
          phoneController: _phoneController,
          passwordController: _passwordController,
          confirmPasswordController: _confirmPasswordController,
        ),
      ],
    );
  }
}
