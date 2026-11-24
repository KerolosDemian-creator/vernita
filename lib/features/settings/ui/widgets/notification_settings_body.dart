import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/settings/ui/widgets/notifications_settings_group.dart';

class NotificationSettingsBody extends StatelessWidget {
  const NotificationSettingsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(title: 'Notifications', centerTitle: true),
            verticalSpace(18),
            const NotificationsSettingsGroup(),
          ],
        ),
      ),
    );
  }
}
