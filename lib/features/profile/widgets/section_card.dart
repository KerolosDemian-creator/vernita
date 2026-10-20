import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'app_card.dart';

/// A card holding a list of rows separated by thin dividers.
/// Pass [title] to show the small label inside the card (Profile screen).
class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.children, this.title});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 2.h),
              child: Text(
                title!.toUpperCase(),
                style: AppTextStyles.font11LightBrownPoppins700W,
              ),
            ),
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1,
                thickness: 1,
                indent: 14.w,
                endIndent: 14.w,
                color: AppColors.divider,
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}
