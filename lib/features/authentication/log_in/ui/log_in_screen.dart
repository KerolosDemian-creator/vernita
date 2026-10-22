import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/log_in_cubit.dart';
import 'widgets/log_in_body.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LogInCubit(),
      child: const Scaffold(body: LogInBody()),
    );
  }
}
