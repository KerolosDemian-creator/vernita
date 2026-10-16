import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/auth_badge.dart';
import '../../../widgets/auth_header.dart';

class ForgetPassHeader extends StatelessWidget {
  const ForgetPassHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthHeader(
      titleSize: 30,
      title: 'Forgot\nPassword?',
      leading: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.maybePop(context),
        child: Icon(
          Icons.arrow_back_rounded,
          size: 20.r,
          color: AppColors.nonSelectedIcon,
        ),
      ),
      subtitle: Text(
        "No worries! Enter your email and we'll send you a reset link.",
        style: AppTextStyles.font14BrownPoppins600W.copyWith(fontSize: 13.sp),
      ),
      badge: AuthBadge.lockWithQuestion(),
    );
  }
}
