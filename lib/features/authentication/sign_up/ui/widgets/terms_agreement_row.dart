import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/auth_checkbox.dart';

/// "I agree to the Terms of Service and Privacy Policy" checkbox row.
class TermsAgreementRow extends StatelessWidget {
  const TermsAgreementRow({
    super.key,
    required this.agreed,
    required this.onChanged,
  });

  final bool agreed;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 4.h),
      child: Row(
        children: [
          AuthCheckbox(value: agreed, onChanged: onChanged),
          SizedBox(width: 10.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: AppTextStyles.font13BrownPoppins500W,
                children: [
                  const TextSpan(text: 'I agree to the '),
                  TextSpan(
                    text: 'Terms of Service',
                    style: AppTextStyles.font13PrimaryPoppins700W,
                  ),
                  const TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: AppTextStyles.font13PrimaryPoppins700W,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
