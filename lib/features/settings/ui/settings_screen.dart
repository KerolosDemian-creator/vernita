import 'package:flutter/material.dart';
import 'package:vernita/features/settings/ui/widgets/settings_body.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SettingsBody());
  }
}
