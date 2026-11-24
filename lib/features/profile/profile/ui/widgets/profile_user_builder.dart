import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_gradient_button.dart';
import 'package:vernita/features/profile/profile/data/models/user_model.dart';
import 'package:vernita/features/profile/profile/logic/profile_cubit.dart';
import 'package:vernita/features/profile/profile/logic/profile_state.dart';

/// Decides what to show: loader / error + retry / the screen content.
/// Used by Profile and Personal Info so they behave the same.
class ProfileUserBuilder extends StatelessWidget {
  const ProfileUserBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context, UserModel user) builder;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      // Don't rebuild the whole screen while a save is in progress.
      buildWhen: (previous, current) =>
          previous.status != current.status || previous.user != current.user,
      builder: (context, state) {
        final user = state.user;

        if (state.status == ProfileStatus.failure) {
          return _ErrorView(
            message: state.errorMessage ?? 'Something went wrong.',
            onRetry: () => context.read<ProfileCubit>().load(),
          );
        }

        if (user == null) {
          return Padding(
            padding: EdgeInsets.only(top: 80.h),
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        return builder(context, user);
      },
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 80.h),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyles.font12GreyPoppins400W,
          ),
          SizedBox(height: 16.h),
          SizedBox(
            width: 160.w,
            child: AppGradientButton(label: 'Try again', onPressed: onRetry),
          ),
        ],
      ),
    );
  }
}
