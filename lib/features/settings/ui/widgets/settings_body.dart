import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/settings/ui/widgets/settings_sections_group.dart';

class SettingsBody extends StatefulWidget {
  const SettingsBody({super.key});

  @override
  State<SettingsBody> createState() => _SettingsBodyState();
}

class _SettingsBodyState extends State<SettingsBody> {
  bool _isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(title: 'Settings'),
            verticalSpace(18),
            SettingsSectionsGroup(
              isDarkMode: _isDarkMode,
              onDarkModeChanged: (value) => setState(() => _isDarkMode = value),
            ),
          ],
        ),
      ),
    );
  }
}
