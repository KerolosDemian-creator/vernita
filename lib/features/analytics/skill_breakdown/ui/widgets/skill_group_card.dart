import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';

class SkillGroupCard extends StatelessWidget {
  const SkillGroupCard({
    super.key,
    required this.title,
    required this.score,
    required this.maxScore,
    required this.icon,
    required this.accent,
    required this.metrics,
  });

  final String title;
  final int score;
  final int maxScore;
  final IconData icon;
  final Color accent;
  final List<Widget> metrics;

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18.r, color: AppColors.nonSelectedIcon),
              horizantalSpace(10),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.font20BrownPoppins700W.copyWith(
                    fontSize: 18.sp,
                  ),
                ),
              ),
              horizantalSpace(8),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '$score',
                      style: AppTextStyles.font20BrownPoppins700W.copyWith(
                        fontSize: 18.sp,
                        color: accent,
                      ),
                    ),
                    TextSpan(
                      text: '/$maxScore',
                      style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                        color: accent,
                        fontSize: 10.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          verticalSpace(12),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.analyticsDivider,
          ),
          verticalSpace(14),
          ..._buildMetrics(),
        ],
      ),
    );
  }

  List<Widget> _buildMetrics() {
    final spacedMetrics = <Widget>[];

    for (var index = 0; index < metrics.length; index++) {
      spacedMetrics.add(metrics[index]);

      if (index != metrics.length - 1) {
        spacedMetrics.add(verticalSpace(14));
      }
    }

    return spacedMetrics;
  }
}