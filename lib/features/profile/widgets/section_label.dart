import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_text_styles.dart';

/// Small uppercase heading above a card ("ACCOUNT", "APP SETTINGS", ...).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 18.h, 4.w, 8.h),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text.toUpperCase(),
              style: AppTextStyles.font11LightBrownPoppins700W,
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}
