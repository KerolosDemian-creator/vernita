import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/round_icon_button.dart';

/// Top bar: [back] title [trailing].
/// Set [showBack] to false for tab screens (Profile, ...).
class AppHeader extends StatelessWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.showBack = true,
    this.trailing,
  });

  final String title;
  final bool centerTitle;
  final bool showBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: centerTitle
          ? Stack(
              alignment: Alignment.center,
              children: [
                if (showBack)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: _BackButton(),
                  ),
                Text(title, style: AppTextStyles.font22BrownPoppins700W),
                if (trailing != null)
                  Align(alignment: Alignment.centerRight, child: trailing!),
              ],
            )
          : Row(
              children: [
                if (showBack) ...[const _BackButton(), horizantalSpace(10)],
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font22BrownPoppins700W,
                  ),
                ),
                if (trailing != null) trailing!,
              ],
            ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return RoundIconButton(
      icon: Icons.arrow_back_rounded,
      iconColor: AppColors.nonSelectedIcon,
      onTap: () => context.pop(),
    );
  }
}
