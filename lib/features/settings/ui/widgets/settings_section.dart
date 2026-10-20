import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/settings/ui/widgets/settings_item.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    super.key,
    required this.sectionTitle,
    required this.children,
  });

  final String sectionTitle;
  final List<SettingsItem> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(sectionTitle, style: AppTextStyles.font12BrowPoppins600W),
        verticalSpace(12),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(28.r),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}
