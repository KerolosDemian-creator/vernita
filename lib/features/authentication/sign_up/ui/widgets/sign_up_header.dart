import 'package:flutter/material.dart';

import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/auth_badge.dart';
import '../../../widgets/auth_header.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthHeader(
      title: 'Sign Up',
      subtitle: Text(
        "Let's get you started.",
        style: AppTextStyles.font16BrownPoppins600W,
      ),
      badge: AuthBadge.profile(),
    );
  }
}
