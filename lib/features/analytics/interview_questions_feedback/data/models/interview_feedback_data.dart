enum AnswerStatus { good, needsImprovement, wrong }

enum ScoreTone { positive, warning, negative }

class InterviewFeedbackData {
  const InterviewFeedbackData({
    required this.sessionType,
    required this.date,
    required this.time,
    required this.duration,
    required this.summary,
    required this.questions,
    this.maxScore = 100,
  });

  final String sessionType;
  final String date;
  final String time;
  final String duration;
  final String summary;
  final List<QuestionFeedbackData> questions;
  final int maxScore;
}

class QuestionFeedbackData {
  const QuestionFeedbackData({
    required this.number,
    required this.question,
    required this.score,
    required this.status,
    required this.scoreTone,
    this.isExpanded = false,
    this.answerTranscript,
    this.aiFeedback,
    this.strengths = const [],
    this.improvements = const [],
    this.betterApproach,
    this.tip,
    this.maxScore = 100,
  });

  final int number;
  final String question;
  final int score;
  final int maxScore;
  final AnswerStatus status;
  final ScoreTone scoreTone;
  final bool isExpanded;
  final String? answerTranscript;
  final String? aiFeedback;
  final List<String> strengths;
  final List<String> improvements;
  final String? betterApproach;
  final String? tip;
}
