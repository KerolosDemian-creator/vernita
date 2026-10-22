import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AuthCheckbox extends StatelessWidget {
  const AuthCheckbox({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!value),
      child: Container(
        width: 20.r,
        height: 20.r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.r),
          gradient: value
              ? const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.lightPeachText, AppColors.peach],
                )
              : null,
          border: value
              ? null
              : Border.all(color: AppColors.nonSelectedIcon, width: 1.5),
        ),
        child: value
            ? Icon(Icons.check_rounded, size: 14.r, color: Colors.white)
            : null,
      ),
    );
  }
}
