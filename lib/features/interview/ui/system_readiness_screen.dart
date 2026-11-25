import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/interview/logic/device_check_cubit.dart';
import 'package:vernita/features/interview/logic/device_check_state.dart';
import 'package:vernita/features/interview/logic/interview_setup_cubit.dart';
import 'package:vernita/features/interview/logic/interview_setup_state.dart';
import 'package:vernita/features/interview/ui/widgets/device_check_cards.dart';
import 'package:vernita/features/interview/ui/widgets/setup_primary_button.dart';
import 'package:vernita/features/interview/ui/widgets/setup_scaffold.dart';

/// Step 2 of 2: camera and microphone check, then enter the interview.
/// Needs an [InterviewSetupCubit] and a [DeviceCheckCubit] above it.
class SystemReadinessScreen extends StatefulWidget {
  const SystemReadinessScreen({super.key});

  @override
  State<SystemReadinessScreen> createState() => _SystemReadinessScreenState();
}

class _SystemReadinessScreenState extends State<SystemReadinessScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<DeviceCheckCubit>();

    if (state == AppLifecycleState.paused) {
      // Free the camera and the microphone while the app is in background.
      cubit.releaseDevices();
    } else if (state == AppLifecycleState.resumed && !cubit.state.canContinue) {
      // Back from the background, or from the settings page where the user
      // may have just allowed the permissions. Don't show the dialog again.
      cubit.start(request: false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InterviewSetupCubit, InterviewSetupState>(
      listenWhen: (previous, current) =>
          previous.submitStatus != current.submitStatus,
      listener: (context, state) {
        if (state.submitStatus == SetupSubmitStatus.ready) {
          // Leave the setup flow: going back from the interview must land on
          // the main screen, not on the setup again.
          context.pushNamedAndRemoveUntil(
            Routes.interviewSession,
            arguments: state.toSessionConfig(),
            predicate: (route) => route.isFirst,
          );
        } else if (state.submitStatus == SetupSubmitStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Something went wrong'),
            ),
          );
        }
      },
      child: SetupScaffold(
        step: 2,
        title: 'System Readiness',
        subtitle: 'Ensure your audio and video are working',
        bottom: BlocBuilder<DeviceCheckCubit, DeviceCheckState>(
          buildWhen: (previous, current) =>
              previous.canContinue != current.canContinue,
          builder: (context, deviceState) {
            return BlocBuilder<InterviewSetupCubit, InterviewSetupState>(
              buildWhen: (previous, current) =>
                  previous.submitStatus != current.submitStatus,
              builder: (context, setupState) {
                final busy =
                    setupState.submitStatus == SetupSubmitStatus.creating;
                return SetupPrimaryButton(
                  label: busy ? 'Starting…' : 'Enter Video Interview',
                  showArrow: !busy,
                  onPressed: deviceState.canContinue && !busy
                      ? () => context.read<InterviewSetupCubit>().startSession()
                      : null,
                );
              },
            );
          },
        ),
        child: Column(
          children: [
            const CameraCheckCard(),
            verticalSpace(16),
            const MicrophoneCheckCard(),
          ],
        ),
      ),
    );
  }
}
