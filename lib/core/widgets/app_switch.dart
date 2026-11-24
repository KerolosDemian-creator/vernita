import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({super.key, required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: onChanged,
      activeThumbColor: AppColors.white,
      activeTrackColor: AppColors.lightPeachText,
      inactiveThumbColor: AppColors.white,
      inactiveTrackColor: AppColors.paleApricot,
      trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
