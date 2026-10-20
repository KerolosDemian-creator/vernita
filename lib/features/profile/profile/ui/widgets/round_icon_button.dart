// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({super.key, required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36.r,
        height: 36.r,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.fieldFill,
          boxShadow: const [
            BoxShadow(
              color: AppColors.fieldShadow,
              offset: Offset(0, 4),
              blurRadius: 12,
              spreadRadius: -2,
            ),
          ],
        ),
        child: Icon(icon, size: 18.r, color: AppColors.brownText),
      ),
    );
  }
}