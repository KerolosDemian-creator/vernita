import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/auth_checkbox.dart';
import '../../../widgets/auth_link_text.dart';

class RememberForgotRow extends StatelessWidget {
  const RememberForgotRow({
    super.key,
    required this.rememberMe,
    required this.onRememberChanged,
    required this.onForgotTap,
  });

  final bool rememberMe;
  final ValueChanged<bool> onRememberChanged;
  final VoidCallback onForgotTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AuthCheckbox(value: rememberMe, onChanged: onRememberChanged),
        SizedBox(width: 10.w),
        Text(
          'Remember me',
          style: AppTextStyles.font13BrownPoppins500W.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        AuthLinkText(label: 'Forgot password?', onTap: onForgotTap),
      ],
    );
  }
}
