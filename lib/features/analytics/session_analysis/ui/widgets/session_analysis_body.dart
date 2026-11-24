import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/session_overall_score_card.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/session_questions_card.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/session_skill_breakdown_card.dart';

class SessionAnalysisBody extends StatelessWidget {
  const SessionAnalysisBody({super.key,});


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
              title: 'Session Analysis',
              trailingIcon: Icons.tune_rounded,
              trailingSemanticLabel: 'Filter',
            ),
            verticalSpace(18),
            SessionOverallScoreCard(),
            verticalSpace(14),
            SessionSkillBreakdownCard(),
            verticalSpace(14),
            SessionQuestionsCard(),
          ],
        ),
      ),
    );
  }
}
