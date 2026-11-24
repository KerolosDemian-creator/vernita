import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.subtitle,
    this.trailingIcon,
    this.onTrailingTap,
    this.trailingSemanticLabel = 'More options',
    this.titleMaxLines = 1,
    this.titleFontSize,
  });

  final String title;
  final bool centerTitle;
  final String? subtitle;
  final IconData? trailingIcon;
  final VoidCallback? onTrailingTap;
  final String trailingSemanticLabel;
  final int titleMaxLines;
  final double? titleFontSize;

  double get _height {
    if (subtitle != null && titleMaxLines > 1) {
      return 72.h;
    }
    if (subtitle != null) {
      return 64.h;
    }
    if (titleMaxLines > 1) {
      return 58.h;
    }
    return 44.h;
  }

  Widget _buildTitle() {
    Widget titleWidget = Text(
      title,
      maxLines: titleMaxLines,
      overflow: TextOverflow.ellipsis,
      textAlign: centerTitle ? TextAlign.center : TextAlign.start,
      style: AppTextStyles.font22BrownPoppins700W.copyWith(
        height: 1.12,
        fontSize: titleFontSize?.sp,
      ),
    );

    if (centerTitle && titleMaxLines == 1) {
      titleWidget = FittedBox(fit: BoxFit.scaleDown, child: titleWidget);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: centerTitle
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        titleWidget,
        if (subtitle != null) ...[
          SizedBox(height: 2.h),
          Text(
            subtitle!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: centerTitle ? TextAlign.center : TextAlign.start,
            style: AppTextStyles.font12BrownPoppins600W.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.lightBrown,
              height: 1.2,
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final titleContent = _buildTitle();

    final backButton = _HeaderIconButton(
      icon: Icons.arrow_back_rounded,
      onTap: () => context.pop(),
      semanticLabel: 'Back',
    );

    final trailingButton = trailingIcon == null
        ? null
        : _HeaderIconButton(
            icon: trailingIcon!,
            onTap: onTrailingTap,
            semanticLabel: trailingSemanticLabel,
          );

    return SizedBox(
      height: _height,
      child: centerTitle
          ? Stack(
              alignment: Alignment.center,
              children: [
                Align(alignment: Alignment.centerLeft, child: backButton),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 52.w),
                  child: titleContent,
                ),
                if (trailingButton != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: trailingButton,
                  ),
              ],
            )
          : Row(
              children: [
                backButton,
                horizantalSpace(10),
                Expanded(child: titleContent),
                if (trailingButton != null) ...[
                  horizantalSpace(10),
                  trailingButton,
                ],
              ],
            ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.onTap,
    required this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Container(
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(50.r),
          ),
          child: Icon(icon, color: AppColors.nonSelectedIcon, size: 22.r),
        ),
      ),
    );
  }
}
