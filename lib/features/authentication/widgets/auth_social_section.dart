import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'auth_divider.dart';
import 'social_buttons_row.dart';

/// Divider ("or continue with") + social buttons.
class AuthSocialSection extends StatelessWidget {
  const AuthSocialSection({super.key, required this.dividerLabel});

  final String dividerLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthDivider(label: dividerLabel),
        SizedBox(height: 18.h),
        const SocialButtonsRow(),
      ],
    );
  }
}
