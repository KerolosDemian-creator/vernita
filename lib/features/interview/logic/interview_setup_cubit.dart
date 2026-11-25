import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/interview/data/models/interview_config.dart';
import 'package:vernita/features/interview/data/models/interview_topic.dart';
import 'package:vernita/features/interview/data/topics_catalog.dart';
import 'package:vernita/features/interview/logic/interview_setup_state.dart';

/// Holds the session settings shared by the two setup screens.
/// Provided once on the setup route, so going back and forth keeps the choices.
class InterviewSetupCubit extends Cubit<InterviewSetupState> {
  InterviewSetupCubit({
    String? role,
    InterviewDifficulty? difficulty,
    List<InterviewTopic>? suggestedTopics,
  }) : super(_initial(role, difficulty, suggestedTopics));

  static InterviewSetupState _initial(
    String? role,
    InterviewDifficulty? difficulty,
    List<InterviewTopic>? suggestedTopics,
  ) {
    // TODO(backend): role, difficulty and suggested topics must come from the
    // CV analysis. These are only defaults until that endpoint is connected.
    final suggested =
        suggestedTopics ??
        [
          TopicsCatalog.byId('design-systems'),
          TopicsCatalog.byId('cross-functional-comms'),
          TopicsCatalog.byId('prototyping'),
        ];

    return InterviewSetupState(
      role: role ?? 'Senior Product Designer',
      difficulty: difficulty ?? InterviewDifficulty.senior,
      suggestedTopics: suggested,
      selectedTopics: suggested,
    );
  }

  void setTopics(List<InterviewTopic> topics) {
    emit(
      state.copyWith(
        selectedTopics: topics.take(InterviewConfig.maxTopics).toList(),
      ),
    );
  }

  void removeTopic(InterviewTopic topic) {
    emit(
      state.copyWith(
        selectedTopics: state.selectedTopics
            .where((item) => item != topic)
            .toList(),
      ),
    );
  }

  Future<void> startSession() async {
    if (!state.canContinue ||
        state.submitStatus == SetupSubmitStatus.creating) {
      return;
    }

    emit(state.copyWith(submitStatus: SetupSubmitStatus.creating));
    try {
      // TODO(backend): create the interview session here (resume id, role,
      // difficulty, topics) and keep the returned session id.
      emit(state.copyWith(submitStatus: SetupSubmitStatus.ready));
    } catch (_) {
      emit(
        state.copyWith(
          submitStatus: SetupSubmitStatus.failure,
          errorMessage: 'Could not start the interview. Please try again.',
        ),
      );
    }
  }
}
