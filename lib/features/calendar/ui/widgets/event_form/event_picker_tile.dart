import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/core/widgets/icon_box.dart';

/// Tappable row: [icon]  value  >   (used for Time and Reminder).
class EventPickerTile extends StatelessWidget {
  const EventPickerTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: AppCard(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Row(
          children: [
            IconBox(icon: icon),
            horizantalSpace(10),
            Expanded(
              child: Text(text, style: AppTextStyles.font12BrownPoppins600W.copyWith(letterSpacing: 0)),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 20.r,
              color: AppColors.nonSelectedIcon,
            ),
          ],
        ),
      ),
    );
  }
}
