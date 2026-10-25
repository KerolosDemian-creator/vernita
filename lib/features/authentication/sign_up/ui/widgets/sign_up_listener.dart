import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_state.dart';

class SignUpListener extends StatelessWidget {
  const SignUpListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Failure || current is Success,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: CircularProgressIndicator(
                  color: AppColors.lightPeachText,
                ),
              ),
            );
          },
          failure: (errMessage) {
            setupErrorState(context, errMessage);
          },
          success: (user) {
            context.pop();
            context.pushReplacementNamed(Routes.main);
          },
        );
      },
      child: SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, String errMessage) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          errMessage,
          style: AppTextStyles.font10LightBrownPoppins600W,
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'Got it',
              style: AppTextStyles.font10LightBrownPoppins600W,
            ),
          ),
        ],
      ),
    );
  }
}
