enum SessionSkillType { technical, delivery, visual }

enum SessionAnswerStatus { strong, needsImprovement }

enum SessionHighlightTone { positive, danger, warning }

class SessionAnalysisData {
  const SessionAnalysisData({
    required this.overallScore,
    required this.scoreDelta,
    required this.sessionLabel,
    required this.percentileLabel,
    required this.overallPercent,
    required this.overallBadgeLabel,
    required this.skills,
    required this.questions,
    this.maxScore = 100,
  });

  final int overallScore;
  final int maxScore;
  final String scoreDelta;
  final String sessionLabel;
  final String percentileLabel;
  final int overallPercent;
  final String overallBadgeLabel;
  final List<SessionSkillSummary> skills;
  final List<SessionQuestionPreview> questions;
}

class SessionSkillSummary {
  const SessionSkillSummary({
    required this.type,
    required this.title,
    required this.score,
    required this.highlight,
    required this.detail,
    required this.highlightTone,
    this.maxScore = 100,
  });

  final SessionSkillType type;
  final String title;
  final int score;
  final int maxScore;
  final String highlight;
  final String detail;
  final SessionHighlightTone highlightTone;
}

class SessionQuestionPreview {
  const SessionQuestionPreview({
    required this.number,
    required this.question,
    required this.status,
    required this.timing,
    required this.feedbackTitle,
    required this.feedback,
    this.maxScore = 100,
  });

  final String number;
  final String question;
  final SessionAnswerStatus status;
  final String timing;
  final String feedbackTitle;
  final String feedback;
  final int maxScore;
}
