import 'package:flutter/material.dart';

import 'package:vernita/core/theme/app_text_styles.dart';
import 'auth_link_text.dart';

/// "Don't have an account? Sign Up" row at the bottom of auth screens.
class AuthSwitchPrompt extends StatelessWidget {
  const AuthSwitchPrompt({
    super.key,
    required this.question,
    required this.actionLabel,
    required this.onTap,
  });

  final String question;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$question ', style: AppTextStyles.font13BrownPoppins500W),
        AuthLinkText(label: actionLabel, onTap: onTap),
      ],
    );
  }
}
