import 'package:flutter/material.dart';
import 'package:vernita/features/authentication/log_in/log_in_body.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: LogInBody());
  }
}
