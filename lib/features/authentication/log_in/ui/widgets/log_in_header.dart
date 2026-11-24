import 'package:flutter/material.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/auth_badge.dart';
import '../../../widgets/auth_header.dart';

class LogInHeader extends StatelessWidget {
  const LogInHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthHeader(
      title: 'Sign In',
      subtitle: Text.rich(
        TextSpan(
          style: AppTextStyles.font14BrownPoppins600W,
          children: [
            TextSpan(
              text: 'Welcome back! ',
              style: TextStyle(color: AppColors.lightPeachText),
            ),
            const TextSpan(text: "Let's get you signed in."),
          ],
        ),
      ),
      badge: AuthBadge.lock(),
    );
  }
}
