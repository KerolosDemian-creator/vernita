import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/forget_pass_cubit.dart';
import 'widgets/forget_pass_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgetPassCubit(),
      child: const Scaffold(body: ForgotPasswordBody()),
    );
  }
}
