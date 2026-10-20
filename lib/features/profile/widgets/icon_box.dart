import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';

/// Rounded square that holds a row's leading icon.
class IconBox extends StatelessWidget {
  const IconBox({
    super.key,
    required this.icon,
    this.background = AppColors.selectedIcon,
    this.color = AppColors.nonSelectedIcon,
  });

  final IconData icon;
  final Color background;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.r,
      height: 34.r,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(11.r),
      ),
      child: Icon(icon, size: 17.r, color: color),
    );
  }
}
