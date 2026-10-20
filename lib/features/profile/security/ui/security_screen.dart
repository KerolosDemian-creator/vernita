import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/profile_scaffold.dart';
import '../logic/security_cubit.dart';
import '../logic/security_state.dart';
import 'widgets/active_sessions_section.dart';
import 'widgets/change_password_section.dart';
import 'widgets/two_factor_section.dart';

/// Screen 5: Security.
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SecurityCubit(),
      child: BlocListener<SecurityCubit, SecurityState>(
        listenWhen: (p, c) =>
            p.status != c.status &&
            (c.status == SecurityStatus.passwordUpdated ||
                c.status == SecurityStatus.loggedOut ||
                c.status == SecurityStatus.failure),
        listener: (context, state) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.message ?? 'Something went wrong')),
            );
        },
        child: const ProfileScaffold(
          title: 'Security',
          child: Column(
            children: [
              ChangePasswordSection(),
              TwoFactorSection(),
              ActiveSessionsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
