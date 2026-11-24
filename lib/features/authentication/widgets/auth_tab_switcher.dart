import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

enum AuthTab { logIn, signUp }

class AuthTabSwitcher extends StatelessWidget {
  const AuthTabSwitcher({
    super.key,
    required this.selected,
    this.onLogInTap,
    this.onSignUpTap,
  });

  final AuthTab selected;
  final VoidCallback? onLogInTap;
  final VoidCallback? onSignUpTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 203.w,
        height: 34.h,
        padding: EdgeInsets.all(4.r),
        decoration: BoxDecoration(
          color: AppColors.tabBackground,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              offset: Offset(0, 1),
              blurRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            _TabItem(
              label: 'Log In',
              isSelected: selected == AuthTab.logIn,
              onTap: onLogInTap,
            ),
            _TabItem(
              label: 'Sign Up',
              isSelected: selected == AuthTab.signUp,
              onTap: onSignUpTap,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  const _TabItem({required this.label, required this.isSelected, this.onTap});

  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: isSelected ? null : onTap,
        child: Container(
          alignment: Alignment.center,
          decoration: isSelected
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100.r),
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.tabSelectedStart,
                      AppColors.tabSelectedEnd,
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 1,
                    ),
                  ],
                )
              : null,
          child: Text(
            label,
            style: AppTextStyles.font12BrownPoppins700W.copyWith(
              color: isSelected ? AppColors.lightPeachText : AppColors.brownText,
            ),
          ),
        ),
      ),
    );
  }
}
