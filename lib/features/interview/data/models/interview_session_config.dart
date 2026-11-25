import 'package:vernita/features/interview/data/models/interview_config.dart';
import 'package:vernita/features/interview/data/models/interview_topic.dart';

/// Everything the interview screen needs to start a session.
class InterviewSessionConfig {
  const InterviewSessionConfig({
    required this.role,
    required this.durationMin,
    required this.difficulty,
    required this.topics,
  });

  final String role;
  final int durationMin;
  final InterviewDifficulty difficulty;
  final List<InterviewTopic> topics;
}
