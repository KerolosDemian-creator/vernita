import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_badge.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.badge,
    this.leading,
    this.titleSize = 40,
  });

  final String title;
  final Widget subtitle;
  final AuthBadge badge;

  /// Optional widget above the title (e.g. back arrow).
  final Widget? leading;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (leading != null) ...[leading!, SizedBox(height: 14.h)],
                Text(title, style: AppTextStyles.title(size: titleSize)),
                SizedBox(height: 6.h),
                subtitle,
              ],
            ),
          ),
        ),
        SizedBox(width: 12.w),
        badge,
      ],
    );
  }
}
