import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../widgets/auth_divider.dart';
import '../../../widgets/auth_primary_button.dart';

/// "Remember your password?" divider + "Back to Login" button.
class ForgetPassFooter extends StatelessWidget {
  const ForgetPassFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthDivider(label: 'Remember your password?'),
        SizedBox(height: 14.h),
        AuthPrimaryButton(
          label: 'Back to Login',
          showArrow: false,
          onPressed: () => Navigator.maybePop(context),
        ),
      ],
    );
  }
}
