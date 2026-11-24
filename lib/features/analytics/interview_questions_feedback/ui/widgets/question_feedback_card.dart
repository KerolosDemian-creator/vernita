import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/widgets/analytics_status_pill.dart';
import 'package:vernita/features/analytics/widgets/analytics_surface_card.dart';

import 'ai_feedback_section.dart';
import 'better_approach_box.dart';
import 'interview_tip_box.dart';
import 'question_feedback_header.dart';
import 'what_to_improve_section.dart';
import 'what_you_did_well_section.dart';
import 'your_answer_section.dart';

class QuestionFeedbackCard extends StatelessWidget {
  const QuestionFeedbackCard({
    super.key,
    required this.number,
    required this.question,
    required this.score,
    required this.maxScore,
    required this.isExpanded,
    required this.statusLabel,
    required this.numberColor,
    required this.scoreColor,
    required this.statusColor,
    required this.statusBackground,
    required this.statusBorder,
    this.statusIcon,
    this.answerDuration,
    this.aiFeedback,
    this.strengthOne,
    this.strengthTwo,
    this.improvementOne,
    this.improvementTwo,
    this.improvementThree,
    this.betterApproach,
    this.tip,
  });

  final int number;
  final String question;
  final int score;
  final int maxScore;
  final bool isExpanded;

  final String statusLabel;

  final Color numberColor;
  final Color scoreColor;
  final Color statusColor;
  final Color statusBackground;
  final BoxBorder statusBorder;

  final IconData? statusIcon;
  final String? answerDuration;
  final String? aiFeedback;

  final String? strengthOne;
  final String? strengthTwo;

  final String? improvementOne;
  final String? improvementTwo;
  final String? improvementThree;

  final String? betterApproach;
  final String? tip;

  @override
  Widget build(BuildContext context) {
    return AnalyticsSurfaceCard(
      padding: EdgeInsets.all(16.w),
      radius: 20.r,
      child: isExpanded
          ? _ExpandedQuestionContent(
              number: number,
              question: question,
              score: score,
              maxScore: maxScore,
              statusLabel: statusLabel,
              numberColor: numberColor,
              scoreColor: scoreColor,
              statusColor: statusColor,
              statusIcon: statusIcon,
              answerDuration: answerDuration,
            )
          : _CollapsedQuestionContent(
              number: number,
              question: question,
              score: score,
              maxScore: maxScore,
              statusLabel: statusLabel,
              numberColor: numberColor,
              scoreColor: scoreColor,
              statusColor: statusColor,
              statusBackground: statusBackground,
              statusBorder: statusBorder,
            ),
    );
  }
}

class _ExpandedQuestionContent extends StatelessWidget {
  const _ExpandedQuestionContent({
    required this.number,
    required this.question,
    required this.score,
    required this.maxScore,
    required this.statusLabel,
    required this.numberColor,
    required this.scoreColor,
    required this.statusColor,
    this.statusIcon,
    this.answerDuration,
  });

  final int number;
  final String question;
  final int score;
  final int maxScore;
  final String statusLabel;

  final Color numberColor;
  final Color scoreColor;
  final Color statusColor;

  final IconData? statusIcon;
  final String? answerDuration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionFeedbackHeader(
          number: number,
          question: question,
          score: score,
          maxScore: maxScore,
          isExpanded: true,
          numberColor: numberColor,
          scoreColor: scoreColor,
        ),

        verticalSpace(7),

        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (statusIcon != null) ...[
                    Icon(statusIcon, size: 12.r, color: statusColor),

                    horizantalSpace(4),
                  ],

                  Text(
                    statusLabel,
                    style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                      color: statusColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),

              verticalSpace(14),

              YourAnswerSection(),

              verticalSpace(14),

              AiFeedbackSection(),

              verticalSpace(14),

              WhatYouDidWellSection(),

              verticalSpace(12),

              WhatToImproveSection(),

              verticalSpace(12),
              BetterApproachBox(),

              verticalSpace(12),
              InterviewTipBox(),
            ],
          ),
        ),
      ],
    );
  }
}

class _CollapsedQuestionContent extends StatelessWidget {
  const _CollapsedQuestionContent({
    required this.number,
    required this.question,
    required this.score,
    required this.maxScore,
    required this.statusLabel,
    required this.numberColor,
    required this.scoreColor,
    required this.statusColor,
    required this.statusBackground,
    required this.statusBorder,
  });

  final int number;
  final String question;
  final int score;
  final int maxScore;
  final String statusLabel;

  final Color numberColor;
  final Color scoreColor;
  final Color statusColor;
  final Color statusBackground;
  final BoxBorder statusBorder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionFeedbackHeader(
          number: number,
          question: question,
          score: score,
          maxScore: maxScore,
          isExpanded: false,
          numberColor: numberColor,
          scoreColor: scoreColor,
        ),

        verticalSpace(8),

        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: AnalyticsStatusPill(
            label: statusLabel,
            foreground: statusColor,
            background: statusBackground,
            border: statusBorder,
          ),
        ),
      ],
    );
  }
}
