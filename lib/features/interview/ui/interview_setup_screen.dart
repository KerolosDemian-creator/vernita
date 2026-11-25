import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/interview/data/models/interview_config.dart';
import 'package:vernita/features/interview/logic/device_check_cubit.dart';
import 'package:vernita/features/interview/logic/interview_setup_cubit.dart';
import 'package:vernita/features/interview/logic/interview_setup_state.dart';
import 'package:vernita/features/interview/ui/system_readiness_screen.dart';
import 'package:vernita/features/interview/ui/widgets/setup_info_card.dart';
import 'package:vernita/features/interview/ui/widgets/setup_primary_button.dart';
import 'package:vernita/features/interview/ui/widgets/setup_scaffold.dart';
import 'package:vernita/features/interview/ui/widgets/topic_chips.dart';
import 'package:vernita/features/interview/ui/widgets/topics_sheet.dart';

/// Step 1 of 2: role, session info and topics.
/// Needs an [InterviewSetupCubit] above it (see the route in app_router).
class InterviewSetupScreen extends StatelessWidget {
  const InterviewSetupScreen({super.key});

  Future<void> _openTopicsSheet(BuildContext context) async {
    final cubit = context.read<InterviewSetupCubit>();
    final result = await showTopicsSheet(
      context,
      selected: cubit.state.selectedTopics,
      suggested: cubit.state.suggestedTopics,
    );
    if (result != null) cubit.setTopics(result);
  }

  void _goToReadiness(BuildContext context) {
    final setupCubit = context.read<InterviewSetupCubit>();

    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MultiBlocProvider(
          providers: [
            // Same cubit instance: the choices made in step 1 are kept.
            BlocProvider<InterviewSetupCubit>.value(value: setupCubit),
            // The camera and microphone live only while step 2 is open.
            BlocProvider<DeviceCheckCubit>(
              create: (_) => DeviceCheckCubit()..start(),
            ),
          ],
          child: const SystemReadinessScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InterviewSetupCubit, InterviewSetupState>(
      builder: (context, state) {
        return SetupScaffold(
          step: 1,
          title: state.role,
          subtitle: 'Configure your interview session',
          bottom: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SetupPrimaryButton(
                label: 'Next',
                showArrow: true,
                onPressed: state.canContinue
                    ? () => _goToReadiness(context)
                    : null,
              ),
              if (!state.canContinue) ...[
                verticalSpace(8),
                Text(
                  'Add at least one topic to continue',
                  style: AppTextStyles.font11GreyPoppins400W,
                ),
              ],
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Session Config',
                style: AppTextStyles.font13BrownPoppins600W,
              ),
              verticalSpace(10),
              Row(
                children: [
                  Expanded(
                    child: SetupInfoCard(
                      icon: Icons.schedule_rounded,
                      label: 'Duration',
                      value: '${state.durationMin} min',
                    ),
                  ),
                  horizantalSpace(12),
                  Expanded(
                    child: SetupInfoCard(
                      icon: Icons.trending_up_rounded,
                      label: 'Difficulty',
                      value: state.difficulty.label,
                    ),
                  ),
                ],
              ),
              verticalSpace(24),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Interview Topics',
                      style: AppTextStyles.font13BrownPoppins600W,
                    ),
                  ),
                  Text(
                    '${state.selectedTopics.length}/${InterviewConfig.maxTopics}',
                    style: AppTextStyles.font11GreyPoppins400W,
                  ),
                ],
              ),
              verticalSpace(10),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final topic in state.selectedTopics)
                    SelectedTopicChip(
                      title: topic.title,
                      onRemove: () => context
                          .read<InterviewSetupCubit>()
                          .removeTopic(topic),
                    ),
                  AddTopicChip(
                    enabled: !state.reachedTopicLimit,
                    onTap: () => _openTopicsSheet(context),
                  ),
                ],
              ),
              verticalSpace(14),
              Text(
                'AI will focus questions heavily on selected topics.',
                style: AppTextStyles.font11GreyPoppins400W,
              ),
            ],
          ),
        );
      },
    );
  }
}
