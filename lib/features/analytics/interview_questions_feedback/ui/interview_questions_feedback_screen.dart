import 'package:flutter/material.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/widgets/interview_feedback_body.dart';

class InterviewQuestionsFeedbackScreen extends StatelessWidget {
  const InterviewQuestionsFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: InterviewFeedbackBody());
  }
}
