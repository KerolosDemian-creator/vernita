import 'package:flutter/material.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/skill_breakdown_item.dart';
import 'package:vernita/features/analytics/widgets/analytics_section_header.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';

class SessionSkillBreakdownCard extends StatelessWidget {
  const SessionSkillBreakdownCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalyticsSectionHeader(
            title: 'Skill Breakdown',
            onViewAll: () => context.pushNamed(Routes.detailedSkillBreakdown),
          ),
          verticalSpace(14),

          // Technical Knowledge
          SkillBreakdownItem(
            icon: Icons.code_rounded,
            title: 'Technical Knowledge',
            score: 85,
            maxScore: 100,
            barColor: AppColors.greenAlert,
            highlight: 'Strong technical knowledge',
            detail: 'Demonstrated good understanding of core concepts.',
            highlightColor: AppColors.positiveGreen,
          ),

          verticalSpace(16),

          SkillBreakdownItem(
            icon: Icons.mic_none_rounded,
            title: 'Communication & Delivery',
            score: 75,
            maxScore: 100,
            barColor: AppColors.lightPeachText,
            highlight: 'Good communication',
            detail: 'Answers were clear and well structured.',
            highlightColor: AppColors.lightPeachText,
          ),
        ],
      ),
    );
  }
}
