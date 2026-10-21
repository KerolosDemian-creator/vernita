import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, this.centerTitle = true});

  final String title;
  final bool centerTitle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44.h,
      child: centerTitle
          ? Stack(
              alignment: Alignment.center,
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: _BackButton(),
                ),
                Text(title, style: AppTextStyles.font22BrownPoppins700W),
              ],
            )
          : Row(
              children: [
                const _BackButton(),
                horizantalSpace(10),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.font22BrownPoppins700W,
                  ),
                ),
              ],
            ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Container(
        width: 40.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Icon(
          Icons.arrow_back_rounded,
          color: AppColors.nonSelectedIcon,
          size: 22.r,
        ),
      ),
    );
  }
}
