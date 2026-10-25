import 'package:flutter/material.dart';
import '../../../widgets/auth_primary_button.dart';

class SignUpSubmitButton extends StatelessWidget {
  const SignUpSubmitButton({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    required this.confirmPasswordController, this.onPressed,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return AuthPrimaryButton(label: 'Create Account', onPressed: onPressed);
  }
}
