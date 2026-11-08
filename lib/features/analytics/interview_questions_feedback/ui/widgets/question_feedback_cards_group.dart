import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/question_feedback_card.dart';

class QuestionFeedbackCardsGroup extends StatelessWidget {
  const QuestionFeedbackCardsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        QuestionFeedbackCard(
          number: 1,
          question: 'How would you design a scalable chat application?',
          score: 62,
          maxScore: 100,
          isExpanded: true,
          statusLabel: 'Needs Improvement',
          statusIcon: Icons.error_outline_rounded,
          numberColor: AppColors.wrongAlert,
          scoreColor: AppColors.wrongAlert,
          statusColor: AppColors.wrongAlert,
          statusBackground: AppColors.analyticsDangerSurface,
          statusBorder: Border.all(color: AppColors.analyticsDangerBorder),
          answerDuration: '01:45',
          aiFeedback:
              'You provided a good high-level overview but missed some key '
              "components. You also didn't explain how your design handles "
              'message delivery guarantees.',
          strengthOne: 'Mentioned horizontal scaling for the backend',
          strengthTwo: 'Good understanding of real-time communication',
          improvementOne: 'Explain database choices and sharding strategy',
          improvementTwo: 'Discuss message delivery (sent, delivered, read)',
          improvementThree: 'Mention offline support and sync mechanism',
          betterApproach:
              'Start with requirements → identify core features → design '
              'system architecture → choose technologies → discuss scaling, '
              'reliability, and trade-offs.',
          tip:
              'Use diagrams to support your explanation for system design '
              'questions.',
        ),

        verticalSpace(12),

        QuestionFeedbackCard(
          number: 2,
          question: 'Explain the CAP theorem with an example.',
          score: 90,
          maxScore: 100,
          isExpanded: false,
          statusLabel: 'Good Answer',
          numberColor: AppColors.positiveGreen,
          scoreColor: AppColors.positiveGreen,
          statusColor: AppColors.positiveGreen,
          statusBackground: AppColors.positiveGreenSurface,
          statusBorder: Border.all(
            color: AppColors.positiveGreen.withValues(alpha: 0.2),
          ),
        ),

        verticalSpace(12),

        QuestionFeedbackCard(
          number: 3,
          question: 'How would you handle 1M concurrent users?',
          score: 68,
          maxScore: 100,
          isExpanded: false,
          statusLabel: 'Needs Improvement',
          numberColor: AppColors.wrongAlert,
          scoreColor: AppColors.analyticsAmber,
          statusColor: AppColors.analyticsAmber,
          statusBackground: AppColors.analyticsWarningSurface,
          statusBorder: Border.all(color: AppColors.analyticsWarningBorder),
        ),

        verticalSpace(12),

        QuestionFeedbackCard(
          number: 4,
          question: 'Design a URL shortener like bit.ly',
          score: 85,
          maxScore: 100,
          isExpanded: false,
          statusLabel: 'Good Answer',
          numberColor: AppColors.positiveGreen,
          scoreColor: AppColors.positiveGreen,
          statusColor: AppColors.positiveGreen,
          statusBackground: AppColors.positiveGreenSurface,
          statusBorder: Border.all(
            color: AppColors.positiveGreen.withValues(alpha: 0.2),
          ),
        ),

        verticalSpace(12),

        QuestionFeedbackCard(
          number: 5,
          question: 'What is the difference between SQL and NoSQL?',
          score: 92,
          maxScore: 100,
          isExpanded: false,
          statusLabel: 'Good Answer',
          numberColor: AppColors.positiveGreen,
          scoreColor: AppColors.positiveGreen,
          statusColor: AppColors.positiveGreen,
          statusBackground: AppColors.positiveGreenSurface,
          statusBorder: Border.all(
            color: AppColors.positiveGreen.withValues(alpha: 0.2),
          ),
        ),

        verticalSpace(12),

        QuestionFeedbackCard(
          number: 6,
          question: 'How would you ensure data consistency?',
          score: 40,
          maxScore: 100,
          isExpanded: false,
          statusLabel: 'Wrong Answer',
          numberColor: AppColors.wrongAlert,
          scoreColor: AppColors.wrongAlert,
          statusColor: AppColors.wrongAlert,
          statusBackground: AppColors.analyticsDangerSurface,
          statusBorder: Border.all(color: AppColors.analyticsDangerBorder),
        ),
      ],
    );
  }
}
