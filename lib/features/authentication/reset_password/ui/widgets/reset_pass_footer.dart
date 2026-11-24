import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/routing/routes.dart';

import '../../../widgets/auth_divider.dart';
import '../../../widgets/auth_primary_button.dart';

class ResetPassFooter extends StatelessWidget {
  const ResetPassFooter({super.key});

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
          onPressed: () => context.pushNamedAndRemoveUntil(
            Routes.logIn,
            predicate: (_) => false,
          ),
        ),
      ],
    );
  }
}
