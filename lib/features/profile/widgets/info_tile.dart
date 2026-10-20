import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_text_styles.dart';
import 'profile_tile.dart';

/// Row with a small bold label and the value under it
/// (used for Full Name / Email / Phone / Location ...).
class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueWidget,
    this.showChevron = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final Widget? valueWidget;
  final bool showChevron;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ProfileTile(
      icon: icon,
      title: label,
      subtitle: value,
      subtitleWidget: valueWidget,
      showChevron: showChevron,
      onTap: onTap,
      titleStyle: AppTextStyles.font13BrownPoppins600W.copyWith(fontSize: 11.sp),
      subtitleStyle: AppTextStyles.font12GreyPoppins400W,
    );
  }
}
