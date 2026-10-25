import 'package:flutter/material.dart';

import 'auth_text_field.dart';

/// Email field used in Log in / Sign up / Forgot password.
class AuthTxtField extends StatelessWidget {
  const AuthTxtField({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      hint: 'Email address',
      icon: Icons.mail_outline_rounded,
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: textInputAction,
    );
  }
}
