import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/core/widgets/icon_box.dart';
import 'package:vernita/features/interview/logic/device_check_cubit.dart';
import 'package:vernita/features/interview/logic/device_check_state.dart';

/// "Allow access" / "Open settings" button, shown only when it helps.
class _PermissionAction extends StatelessWidget {
  const _PermissionAction({required this.status});

  final DeviceStatus status;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeviceCheckCubit>();

    switch (status) {
      case DeviceStatus.denied:
        return TextButton(
          onPressed: cubit.retry,
          child: Text(
            'Allow access',
            style: AppTextStyles.font13PrimaryPoppins700W,
          ),
        );
      case DeviceStatus.permanentlyDenied:
        return TextButton(
          onPressed: cubit.openSettings,
          child: Text(
            'Open settings',
            style: AppTextStyles.font13PrimaryPoppins700W,
          ),
        );
      case DeviceStatus.checking:
      case DeviceStatus.ready:
      case DeviceStatus.unavailable:
        return const SizedBox.shrink();
    }
  }
}

// ------------------------------- Camera -------------------------------

class CameraCheckCard extends StatelessWidget {
  const CameraCheckCard({super.key});

  String _label(DeviceStatus status) {
    switch (status) {
      case DeviceStatus.ready:
        return 'Camera Active';
      case DeviceStatus.checking:
        return 'Checking camera…';
      case DeviceStatus.denied:
      case DeviceStatus.permanentlyDenied:
        return 'Camera access needed';
      case DeviceStatus.unavailable:
        return 'Camera unavailable';
    }
  }

  String _message(DeviceStatus status) {
    switch (status) {
      case DeviceStatus.denied:
        return 'Allow camera access so the AI interviewer can see you.';
      case DeviceStatus.permanentlyDenied:
        return 'Camera access is turned off. Enable it from the app settings.';
      case DeviceStatus.unavailable:
        return 'We could not start the camera on this device.';
      case DeviceStatus.checking:
      case DeviceStatus.ready:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DeviceCheckCubit>();

    return BlocBuilder<DeviceCheckCubit, DeviceCheckState>(
      buildWhen: (previous, current) => previous.camera != current.camera,
      builder: (context, state) {
        final status = state.camera;
        final controller = cubit.cameraController;

        return AppCard(
          radius: 28,
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 8.r,
                    height: 8.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: status == DeviceStatus.ready
                          ? AppColors.greenAlert
                          : status == DeviceStatus.checking
                          ? AppColors.analyticsAmber
                          : AppColors.wrongAlert,
                    ),
                  ),
                  horizantalSpace(8),
                  Expanded(
                    child: Text(
                      _label(status),
                      style: AppTextStyles.font12BrownPoppins600W,
                    ),
                  ),
                  if (status == DeviceStatus.ready)
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 22.r,
                      color: AppColors.greenAlert,
                    ),
                ],
              ),
              verticalSpace(14),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: SizedBox(
                  width: double.infinity,
                  height: 300.h,
                  child: status == DeviceStatus.ready && controller != null
                      ? _CoverPreview(controller: controller)
                      : Container(
                          color: AppColors.warmPeach,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (status == DeviceStatus.checking)
                                const CircularProgressIndicator(
                                  color: AppColors.lightPeachText,
                                )
                              else ...[
                                Icon(
                                  Icons.person_rounded,
                                  size: 72.r,
                                  color: AppColors.nonSelectedIcon,
                                ),
                                verticalSpace(8),
                                Text(
                                  _message(status),
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.font12GreyPoppins400W,
                                ),
                                _PermissionAction(status: status),
                              ],
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Fills the rectangle with the camera image (no black bars, no stretching).
class _CoverPreview extends StatelessWidget {
  const _CoverPreview({required this.controller});

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    final size = controller.value.previewSize;
    if (size == null) return const SizedBox.shrink();

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(
        // The plugin reports the size in landscape; the phone is in portrait.
        width: size.height,
        height: size.width,
        child: CameraPreview(controller),
      ),
    );
  }
}

// ----------------------------- Microphone -----------------------------

class MicrophoneCheckCard extends StatelessWidget {
  const MicrophoneCheckCard({super.key});

  String _message(DeviceStatus status) {
    switch (status) {
      case DeviceStatus.denied:
        return 'Allow microphone access so the AI interviewer can hear you.';
      case DeviceStatus.permanentlyDenied:
        return 'Microphone access is turned off. Enable it from the app settings.';
      case DeviceStatus.unavailable:
        return 'We could not start the microphone on this device.';
      case DeviceStatus.checking:
      case DeviceStatus.ready:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCheckCubit, DeviceCheckState>(
      buildWhen: (previous, current) =>
          previous.mic != current.mic ||
          previous.level != current.level ||
          previous.noisy != current.noisy,
      builder: (context, state) {
        final status = state.mic;
        final isReady = status == DeviceStatus.ready;
        final hasProblem = !isReady && status != DeviceStatus.checking;
        final showWarning = hasProblem || (isReady && state.noisy);

        return AppCard(
          padding: EdgeInsets.all(14.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconBox(
                    icon: Icons.mic_rounded,
                    background: showWarning
                        ? AppColors.analyticsDangerSurface
                        : AppColors.selectedIcon,
                    color: showWarning
                        ? AppColors.wrongAlert
                        : AppColors.nonSelectedIcon,
                  ),
                  horizantalSpace(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Microphone',
                          style: AppTextStyles.font13BrownPoppins600W,
                        ),
                        verticalSpace(6),
                        if (isReady)
                          _LevelBars(level: state.level, noisy: state.noisy)
                        else if (status == DeviceStatus.checking)
                          Text(
                            'Checking microphone…',
                            style: AppTextStyles.font11GreyPoppins400W,
                          ),
                      ],
                    ),
                  ),
                  if (status == DeviceStatus.checking)
                    SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.lightPeachText,
                      ),
                    )
                  else
                    Icon(
                      showWarning
                          ? Icons.error_outline_rounded
                          : Icons.check_circle_outline_rounded,
                      size: 22.r,
                      color: showWarning
                          ? AppColors.wrongAlert
                          : AppColors.greenAlert,
                    ),
                ],
              ),
              if (isReady && state.noisy) ...[
                verticalSpace(10),
                Text(
                  'Noise detected in the background, please go to a quiet place.',
                  style: AppTextStyles.font11DangerPoppins600W,
                ),
              ],
              if (hasProblem) ...[
                verticalSpace(10),
                Text(
                  _message(status),
                  style: AppTextStyles.font11DangerPoppins600W,
                ),
                _PermissionAction(status: status),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _LevelBars extends StatelessWidget {
  const _LevelBars({required this.level, required this.noisy});

  static const int _count = 16;

  final double level;
  final bool noisy;

  @override
  Widget build(BuildContext context) {
    final active = (level * _count).round();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < _count; i++)
          Padding(
            padding: EdgeInsetsDirectional.only(end: 3.w),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 4.w,
              height: (6 + (i % 4) * 3).h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.r),
                color: i < active
                    ? (noisy ? AppColors.wrongAlert : AppColors.lightPeachText)
                    : AppColors.analyticsDivider,
              ),
            ),
          ),
      ],
    );
  }
}
