import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../../../widgets/auth_bg.dart';
import '../../../widgets/auth_snack_bar.dart';
import '../../logic/forget_pass_cubit.dart';
import '../../logic/forget_pass_state.dart';
import 'forget_pass_footer.dart';
import 'forget_pass_form.dart';
import 'forget_pass_header.dart';
import 'secure_card.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgetPassCubit, ForgetPassState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == ForgetPassStatus.success ||
            state.status == ForgetPassStatus.failure) {
          showAuthSnackBar(context, state.message ?? 'Something went wrong');
        }
      },
      child: AuthBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ForgetPassHeader(),
            SizedBox(height: 24.h),
            const ForgetPassForm(),
            SizedBox(height: 12.h),
            const SecureCard(),
            SizedBox(height: 16.h),
            const ForgetPassFooter(),
          ],
        ),
      ),
    );
  }
}
