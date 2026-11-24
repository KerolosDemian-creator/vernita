import 'package:flutter/material.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/analytics/widgets/analytics_section_header.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';
import 'package:vernita/features/analytics/session_analysis/ui/widgets/question_feedback_item.dart';

class SessionQuestionsCard extends StatelessWidget {
  const SessionQuestionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalyticsSectionHeader(
            title: 'Interview Questions & Feedback',
            titleMaxLines: 2,
            onViewAll: () =>
                context.pushNamed(Routes.interviewQuestionsFeedback),
          ),
          verticalSpace(12),

          QuestionFeedbackItem(
            number: 'Q1',
            question: 'Tell me about yourself and your experience.',
            isStrong: true,
            timing: '1:25',
            feedbackTitle: 'Excellent answer!',
            feedback:
                'Your answer was clear, structured, and demonstrated confidence.',
            onTap: () =>
                context.pushNamed(Routes.interviewQuestionsFeedback),
          ),

          verticalSpace(12),

          QuestionFeedbackItem(
            number: 'Q2',
            question: 'What are your strengths and weaknesses?',
            isStrong: false,
            timing: '2:10',
            feedbackTitle: 'Try to be more specific',
            feedback:
                'Support your answer with real examples and explain how you handle your weaknesses.',
            onTap: () =>
                context.pushNamed(Routes.interviewQuestionsFeedback),
          ),
        ],
      ),
    );
  }
}