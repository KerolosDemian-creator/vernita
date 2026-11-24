import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/app_regex.dart';
import 'package:vernita/features/authentication/sign_up/data/models/sign_up_request_model.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/authentication/sign_up/ui/widgets/sign_up_listener.dart';
import '../../../widgets/auth_text_field.dart';
import 'sign_up_submit_button.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SignUpCubit>();
    return Form(
      key: cubit.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            hint: 'Full name',
            icon: Icons.person_outline_rounded,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: cubit.fullNamecontroller,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Email address',
            icon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            controller: cubit.emailcontroller,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !AppRegex.isEmailValid(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            hint: 'Phone number',
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: cubit.phonecontroller,
            validator: (value) {
              if (value == null ||
                  value.trim().isEmpty ||
                  !AppRegex.isPhoneNumberValid(value.trim())) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            isPassword: true,
            hint: 'Enter your password',
            icon: Icons.lock_outline_rounded,
            controller: cubit.passwordcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          SizedBox(height: 8.h),
          AuthTextField(
            isPassword: true,
            hint: 'Confirm password',
            textInputAction: TextInputAction.done,
            icon: Icons.lock_outline_rounded,
            controller: cubit.confirmPasswordcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != cubit.passwordcontroller.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          SizedBox(height: 16.h),
          SignUpSubmitButton(
            onPressed: () {
              validateThenDoSignUp(context);
            },
            nameController: cubit.fullNamecontroller,
            emailController: cubit.emailcontroller,
            phoneController: cubit.phonecontroller,
            passwordController: cubit.passwordcontroller,
            confirmPasswordController: cubit.confirmPasswordcontroller,
          ),
          SignUpListener(),
        ],
      ),
    );
  }

  void validateThenDoSignUp(BuildContext context) {
    final signUpCubit = context.read<SignUpCubit>();

    if (signUpCubit.formKey.currentState!.validate()) {
      signUpCubit.emitSignUpState(
        SignUpRequestModel(
          name: signUpCubit.fullNamecontroller.text,
          email: signUpCubit.emailcontroller.text,
          phone: signUpCubit.phonecontroller.text,
          password: signUpCubit.passwordcontroller.text,
        ),
      );
    }
  }
}
