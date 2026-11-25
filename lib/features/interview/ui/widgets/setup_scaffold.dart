import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/round_icon_button.dart';

/// Gradient background + "Step x of 2" header + scrollable body + a pinned
/// bottom area for the main button. Shared by both interview setup screens.
class SetupScaffold extends StatelessWidget {
  const SetupScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.subtitle,
    required this.child,
    required this.bottom,
  });

  final int step;
  final String title;
  final String subtitle;
  final Widget child;
  final Widget bottom;

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
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  child: SizedBox(
                    height: 40.r,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RoundIconButton(
                            icon: Icons.arrow_back_rounded,
                            onTap: () => Navigator.maybePop(context),
                          ),
                        ),
                        Text(
                          'Step $step of 2',
                          style: AppTextStyles.font13BrownPoppins500W,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.font22BrownPoppins700W,
                        ),
                        verticalSpace(6),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyles.font12GreyPoppins400W,
                        ),
                        verticalSpace(24),
                        child,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 16.h),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
