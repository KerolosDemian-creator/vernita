import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/analytics/skill_breakdown/ui/widgets/skill_card_item.dart';
import 'package:vernita/features/analytics/skill_breakdown/ui/widgets/skill_metric_item.dart';

class SkillBreakdownBody extends StatelessWidget {
  const SkillBreakdownBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(
              title: 'Detailed Skill Breakdown',
              subtitle: 'Your interview performance across key skill areas',
              trailingIcon: Icons.more_vert_rounded,
            ),
            verticalSpace(18),

            SkillCardItem(
              title: 'Technical Skills',
              score: 78,
              maxScore: 100,
              icon: Icons.code_rounded,
              accent: AppColors.lightPeachText,
              skillItems: [
                SkillMetricItem(
                  title: 'Problem Solving',
                  score: 85,
                  maxScore: 100,
                  detail: 'You demonstrated good logical thinking.',
                  accent: AppColors.lightPeachText,
                ),
                SkillMetricItem(
                  title: 'Technical Knowledge',
                  score: 72,
                  maxScore: 100,
                  detail: 'Some technical concepts need more practice.',
                  accent: AppColors.lightPeachText,
                ),
              ],
            ),

            verticalSpace(14),

            SkillCardItem(
              title: 'Communication & Delivery',
              score: 82,
              maxScore: 100,
              icon: Icons.mic_none_rounded,
              accent: AppColors.lightPeachText,
              skillItems: [
                SkillMetricItem(
                  title: 'Clarity',
                  score: 90,
                  maxScore: 100,
                  detail: 'Your answers were clear and easy to follow.',
                  accent: AppColors.lightPeachText,
                ),
                SkillMetricItem(
                  title: 'Confidence',
                  score: 74,
                  maxScore: 100,
                  detail: 'Try to maintain a more confident tone.',
                  accent: AppColors.lightPeachText,
                ),
              ],
            ),

            verticalSpace(14),

            SkillCardItem(
              title: 'Visual Communication',
              score: 68,
              maxScore: 100,
              icon: Icons.visibility_outlined,
              accent: AppColors.analyticsAmber,
              skillItems: [
                SkillMetricItem(
                  title: 'Eye Contact',
                  score: 65,
                  maxScore: 100,
                  detail: 'Maintain eye contact more consistently.',
                  accent: AppColors.analyticsAmber,
                ),
                SkillMetricItem(
                  title: 'Body Language',
                  score: 71,
                  maxScore: 100,
                  detail: 'Your posture was generally good.',
                  accent: AppColors.analyticsAmber,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
