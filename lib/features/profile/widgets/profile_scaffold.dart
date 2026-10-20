import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'round_icon_button.dart';

/// Gradient background + top bar (back / title / trailing) + scrollable body.
/// Shared by Profile, Personal Info, Settings, Notifications and Security.
class ProfileScaffold extends StatelessWidget {
  const ProfileScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBack = true,
    this.trailing,
  });

  final String title;
  final Widget child;
  final bool showBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
        ),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.authGradientTop, AppColors.beige],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 4.h),
                  child: SizedBox(
                    height: 40.r,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (showBack)
                          Align(
                            alignment: Alignment.centerLeft,
                            child: RoundIconButton(
                              icon: Icons.arrow_back_rounded,
                              onTap: () => Navigator.maybePop(context),
                            ),
                          ),
                        Text(title, style: AppTextStyles.font18BrownPoppins700W),
                        if (trailing != null)
                          Align(
                            alignment: Alignment.centerRight,
                            child: trailing!,
                          ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 24.h),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
