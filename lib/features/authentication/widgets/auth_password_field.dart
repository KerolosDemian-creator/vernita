import 'package:flutter/material.dart';

import 'auth_text_field.dart';

/// Password field (with show/hide toggle) used in Log in / Sign up.
class AuthPasswordField extends StatelessWidget {
  const AuthPasswordField({
    super.key,
    required this.controller,
    this.hint = 'Password',
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputAction textInputAction;

  @override
  Widget build(BuildContext context) {
    return AuthTextField(
      hint: hint,
      icon: Icons.lock_outline_rounded,
      controller: controller,
      isPassword: true,
      textInputAction: textInputAction,
    );
  }
}
