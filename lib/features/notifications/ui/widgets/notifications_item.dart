import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class NotificationsItem extends StatelessWidget {
  const NotificationsItem({
    super.key,
    this.iconBackgroundGradient,
    this.iconBackgroundColor,
    required this.icon,
    required this.notificationTitle,
    this.notificationDate,
    this.unreadIcon,
  });

  final LinearGradient? iconBackgroundGradient;
  final Color? iconBackgroundColor;
  final SvgPicture icon;
  final String notificationTitle;
  final String? notificationDate;
  final SvgPicture? unreadIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      constraints: BoxConstraints(minHeight: 75.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(13.r),
            decoration: BoxDecoration(
              color: iconBackgroundGradient == null
                  ? iconBackgroundColor
                  : null,
              gradient: iconBackgroundGradient,
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: icon,
          ),
          horizantalSpace(10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  notificationTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font12BrownPoppins600W,
                ),
                if (notificationDate != null && notificationDate!.isNotEmpty)
                  Text(
                    notificationDate!,
                    style: AppTextStyles.font10LightBrownPoppins600W,
                  ),
              ],
            ),
          ),
          if (unreadIcon != null) ...[horizantalSpace(10), unreadIcon!],
        ],
      ),
    );
  }
}
