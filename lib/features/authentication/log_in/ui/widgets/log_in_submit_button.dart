import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../widgets/auth_primary_button.dart';
import '../../logic/log_in_cubit.dart';

class LogInSubmitButton extends StatelessWidget {
  const LogInSubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthPrimaryButton(
      label: 'Login',
      onPressed: () => _validateAndSubmit(context),
    );
  }

  void _validateAndSubmit(BuildContext context) {
    final cubit = context.read<LogInCubit>();
    if (cubit.formKey.currentState!.validate()) {
      cubit.submit();
    }
  }
}