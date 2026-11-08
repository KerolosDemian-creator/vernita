import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/widgets/app_header.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/feedback_actions.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/interview_feedback_summary.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/question_analytics_card.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/question_feedback_cards_group.dart';

class InterviewFeedbackBody extends StatelessWidget {
  const InterviewFeedbackBody({super.key});

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
              title: 'Interview Questions & Feedback',
              centerTitle: false,
              titleMaxLines: 2,
              titleFontSize: 20.5,
              trailingIcon: Icons.more_vert_rounded,
            ),

            verticalSpace(14),

            const InterviewFeedbackSummary(),

            verticalSpace(14),
            QuestionFeedbackCardsGroup(),
            verticalSpace(14),

            const QuestionAnalyticsCard(),

            verticalSpace(18),

            const FeedbackActions(),
          ],
        ),
      ),
    );
  }
}
