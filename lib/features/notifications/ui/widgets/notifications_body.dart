import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/notifications/ui/widgets/all_or_unread.dart';
import 'package:vernita/features/notifications/ui/widgets/group_of_notificaions.dart';
import 'package:vernita/features/notifications/ui/widgets/notifications_header.dart';

class NotificationsBody extends StatelessWidget {
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationsHeader(),
              verticalSpace(13),
              AllOrUnread(),
              verticalSpace(15),
              GroupOfNotificaions(),
            ],
          ),
        ),
      ),
    );
  }
}
