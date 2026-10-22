import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/auth_primary_button.dart';
import '../../logic/log_in_cubit.dart';
import '../../logic/log_in_state.dart';

class LogInSubmitButton extends StatelessWidget {
  const LogInSubmitButton({
    super.key,
    required this.emailController,
    required this.passwordController,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogInCubit, LogInState>(
      buildWhen: (p, c) => p.status != c.status,
      builder: (context, state) => AuthPrimaryButton(
        label: 'Login',
        onPressed: state.status == LogInStatus.loading
            ? null
            : () => context.read<LogInCubit>().submit(
                  email: emailController.text,
                  password: passwordController.text,
                ),
      ),
    );
  }
}
