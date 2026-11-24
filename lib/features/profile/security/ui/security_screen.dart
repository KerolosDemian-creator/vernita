import 'package:flutter/material.dart';
import '../../widgets/profile_scaffold.dart';
import 'widgets/active_sessions_section.dart';
import 'widgets/change_password_section.dart';
import 'widgets/two_factor_section.dart';

/// Screen 5: Security.
class SecurityScreen extends StatelessWidget {
  const SecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScaffold(
      title: 'Security',
      child: Column(
        children: [
          ChangePasswordSection(),
          TwoFactorSection(),
          ActiveSessionsSection(),
        ],
      ),
    );
  }
}
