import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_badge.dart';
import 'package:vernita/features/authentication/widgets/auth_header.dart';

import '../../logic/reset_pass_cubit.dart';

class ResetPassHeader extends StatelessWidget {
  const ResetPassHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final email = context.read<ResetPassCubit>().emailController.text.trim();
    final target = email.isEmpty ? 'your email' : email;

    return AuthHeader(
      titleSize: 30,
      title: 'Reset\nPassword',
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
        'If an account exists for $target, enter the 6-digit code sent to it. '
        'The code expires in 10 minutes.',
        style: AppTextStyles.font14BrownPoppins600W.copyWith(fontSize: 13.sp),
      ),
      badge: AuthBadge.lockWithQuestion(),
    );
  }
}
