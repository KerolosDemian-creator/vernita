import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// A chosen topic with an "x" to remove it.
class SelectedTopicChip extends StatelessWidget {
  const SelectedTopicChip({
    super.key,
    required this.title,
    required this.onRemove,
  });

  final String title;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 40.h),
      padding: EdgeInsetsDirectional.only(start: 14.w, end: 4.w),
      decoration: BoxDecoration(
        color: AppColors.analyticsDivider,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: AppTextStyles.font12BrownPoppins600W),
          Semantics(
            button: true,
            label: 'Remove $title',
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onRemove,
              child: Padding(
                padding: EdgeInsets.all(8.r),
                child: Icon(
                  Icons.close_rounded,
                  size: 16.r,
                  color: AppColors.lightBrown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// "+ Add Topic" chip. Disabled when the topic limit is reached.
class AddTopicChip extends StatelessWidget {
  const AddTopicChip({super.key, required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.45,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: BoxConstraints(minHeight: 40.h),
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.nonSelectedIcon),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add_rounded, size: 16.r, color: AppColors.lightBrown),
              horizantalSpace(4),
              Text('Add Topic', style: AppTextStyles.font12GreyPoppins400W),
            ],
          ),
        ),
      ),
    );
  }
}

/// A topic inside the "Select Interview Topics" sheet.
class SelectableTopicChip extends StatelessWidget {
  const SelectableTopicChip({
    super.key,
    required this.title,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String title;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);

    return Opacity(
      opacity: enabled || selected ? 1 : 0.45,
      child: Semantics(
        button: true,
        selected: selected,
        label: title,
        child: InkWell(
          borderRadius: radius,
          onTap: enabled || selected ? onTap : null,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            constraints: BoxConstraints(minHeight: 40.h),
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              borderRadius: radius,
              color: selected ? null : AppColors.fieldFill,
              gradient: selected
                  ? const LinearGradient(
                      colors: [AppColors.lightPeachText, AppColors.peach],
                    )
                  : null,
              border: Border.all(
                color: selected
                    ? Colors.transparent
                    : AppColors.analyticsDivider,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (selected) ...[
                  Container(
                    width: 16.r,
                    height: 16.r,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 12.r,
                      color: AppColors.lightPeachText,
                    ),
                  ),
                  horizantalSpace(6),
                ],
                Text(title, style: AppTextStyles.font12BrownPoppins600W),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
