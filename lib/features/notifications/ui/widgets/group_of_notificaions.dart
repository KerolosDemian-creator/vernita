import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/notifications/ui/widgets/notification_date_header.dart';
import 'package:vernita/features/notifications/ui/widgets/notifications_item.dart';

class GroupOfNotificaions extends StatelessWidget {
  const GroupOfNotificaions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Today
        NotificationDateHeader(sectionTile: 'TODAY'),
        verticalSpace(10),

        // Interview Analysis Ready
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.analyticsIcon),
          iconBackgroundGradient: AppColors.analyticsIconContainerGradient,
          notificationTitle: 'Interview Analysis Ready',
          notificationDate: '2M AGO',
          unreadIcon: SvgPicture.asset(AppSvgs.unreadNotificationIcon),
        ),

        verticalSpace(10),

        // Upcoming Interview
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.dateNotificationIcon),
          iconBackgroundColor: AppColors.paleApricot,
          notificationTitle: 'Upcoming Interview',
          notificationDate: 'Reminder',
          unreadIcon: SvgPicture.asset(AppSvgs.unreadNotificationIcon),
        ),
        verticalSpace(10),

        /// Yesterday
        NotificationDateHeader(sectionTile: 'YESTERDAY'),
        verticalSpace(10),

        // New Milestone Reached
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.milestonNotificationIcon),
          iconBackgroundColor: AppColors.softBlush,
          notificationTitle: 'New Milestone Reached!',
          notificationDate: 'YESTERDAY, 4:30 PM',
        ),
        verticalSpace(10),
        // New Feature: Custom Topics
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.featureNotificationIcon),
          iconBackgroundColor: AppColors.softSage,
          notificationTitle: 'New Feature: Custom Topics',
        ),
        verticalSpace(10),

        /// Last Week
        NotificationDateHeader(sectionTile: 'LAST WEEK'),
        verticalSpace(10),

        // Weekly Progress Summary
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.progressNotificationIcon),
          iconBackgroundColor: AppColors.pastelPeriwinkle,
          notificationTitle: 'Weekly Progress Summary',
          notificationDate: 'OCT 24, 2023',
        ),
        verticalSpace(10),
        // New Avatar Available
        NotificationsItem(
          icon: SvgPicture.asset(AppSvgs.avatarAvailableIcon),
          iconBackgroundColor: AppColors.softLilac,
          notificationTitle: 'New Avatar Available',
          notificationDate: 'OCT 22, 2023',
        ),
      ],
    );
  }
}
