enum InterviewDifficulty {
  junior('Junior'),
  mid('Mid-level'),
  senior('Senior');

  const InterviewDifficulty(this.label);

  final String label;
}

/// Fixed rules of the interview setup flow.
abstract final class InterviewConfig {
  /// The session length is fixed: the user sees it but can't change it.
  /// Keep this the single source of truth (the interview screen timer must
  /// read the same value, or the value sent by the backend).
  static const int sessionDurationMin = 30;

  /// Max topics per session, so the AI can really focus on them.
  static const int maxTopics = 5;
}
