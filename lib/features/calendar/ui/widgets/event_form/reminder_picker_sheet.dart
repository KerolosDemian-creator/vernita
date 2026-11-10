import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';

/// Bottom sheet with the reminder choices. Returns the chosen minutes.
Future<int?> showReminderPicker(BuildContext context, int current) {
  return showModalBottomSheet<int>(
    context: context,
    backgroundColor: AppColors.warmCream,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
    ),
    builder: (_) => SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final minutes in reminderOptions)
              ListTile(
                title: Text(
                  reminderLabel(minutes),
                  style: AppTextStyles.font14BrownPoppins600W,
                ),
                trailing: minutes == current
                    ? const Icon(
                        Icons.check_rounded,
                        color: AppColors.lightPeachText,
                      )
                    : null,
                onTap: () => Navigator.pop(context, minutes),
              ),
          ],
        ),
      ),
    ),
  );
}
