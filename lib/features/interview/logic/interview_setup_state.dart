import 'package:vernita/features/interview/data/models/interview_config.dart';
import 'package:vernita/features/interview/data/models/interview_session_config.dart';
import 'package:vernita/features/interview/data/models/interview_topic.dart';

enum SetupSubmitStatus { idle, creating, ready, failure }

class InterviewSetupState {
  const InterviewSetupState({
    required this.role,
    required this.difficulty,
    this.durationMin = InterviewConfig.sessionDurationMin,
    this.suggestedTopics = const [],
    this.selectedTopics = const [],
    this.submitStatus = SetupSubmitStatus.idle,
    this.errorMessage,
  });

  final String role;
  final InterviewDifficulty difficulty;
  final int durationMin;

  /// Topics suggested from the CV analysis.
  final List<InterviewTopic> suggestedTopics;
  final List<InterviewTopic> selectedTopics;

  final SetupSubmitStatus submitStatus;
  final String? errorMessage;

  bool get canContinue => selectedTopics.isNotEmpty;
  bool get reachedTopicLimit =>
      selectedTopics.length >= InterviewConfig.maxTopics;

  InterviewSessionConfig toSessionConfig() => InterviewSessionConfig(
    role: role,
    durationMin: durationMin,
    difficulty: difficulty,
    topics: selectedTopics,
  );

  /// Note: [errorMessage] is reset when it isn't passed.
  InterviewSetupState copyWith({
    List<InterviewTopic>? selectedTopics,
    SetupSubmitStatus? submitStatus,
    String? errorMessage,
  }) {
    return InterviewSetupState(
      role: role,
      difficulty: difficulty,
      durationMin: durationMin,
      suggestedTopics: suggestedTopics,
      selectedTopics: selectedTopics ?? this.selectedTopics,
      submitStatus: submitStatus ?? this.submitStatus,
      errorMessage: errorMessage,
    );
  }
}
