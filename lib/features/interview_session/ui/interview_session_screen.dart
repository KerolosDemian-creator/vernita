import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/interview/data/models/interview_session_config.dart';
import 'package:vernita/features/interview_session/ui/widgets/control_bar.dart';
import 'package:vernita/features/interview_session/ui/widgets/interviewer_avatar_card.dart';
import 'package:vernita/features/interview_session/ui/widgets/status_pill.dart';

/// Interview session screen: the video call with the AI interviewer (UI only).
///
/// TODO(backend/ai): the AI team provides the interviewer avatar. Pass it to
/// [InterviewerAvatarCard.avatar] (a video texture / WebView / Rive ...).
/// Until then an anonymous placeholder is shown in its place.
/// TODO(backend): [config] holds the session settings chosen in the setup flow.
class InterviewSessionScreen extends StatefulWidget {
  const InterviewSessionScreen({super.key, this.config});

  final InterviewSessionConfig? config;

  @override
  State<InterviewSessionScreen> createState() => _InterviewSessionScreenState();
}

class _InterviewSessionScreenState extends State<InterviewSessionScreen> {
  // TODO(ai): these two come from the interviewer the AI picks.
  static const String _interviewerName = 'Sarah (HR)';
  static const String _interviewerRole = 'AI Interviewer';

  static const Color _red = Color(0xFFEF4444);

  final ValueNotifier<Duration> _elapsed = ValueNotifier(Duration.zero);
  Timer? _timer;

  bool _speakerOn = true;
  bool _captionsOn = false;

  /// UI test only: tap the avatar to switch the "AI is speaking" animation.
  /// TODO(ai): drive this from the real speaking state.
  bool _aiSpeaking = true;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsed.value += const Duration(seconds: 1);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _elapsed.dispose();
    super.dispose();
  }

  Future<void> _confirmEnd() async {
    final end = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        title: Text(
          'End interview?',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.brownText,
          ),
        ),
        content: Text(
          'Your session will stop and the interview will be closed.',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 13.sp,
            color: AppColors.greyText,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                color: AppColors.brownText,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(
              'End',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w700,
                color: _red,
              ),
            ),
          ),
        ],
      ),
    );

    if (end == true && mounted) {
      // TODO(backend): close the interview session here.
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _confirmEnd();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.authGradientTop, AppColors.beige],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const StatusPill(
                          leading: Icon(
                            Icons.shield_outlined,
                            size: 14,
                            color: AppColors.lightBrown,
                          ),
                          label: 'End-to-End Encrypted',
                        ),
                        SizedBox(height: 8.h),
                        ValueListenableBuilder<Duration>(
                          valueListenable: _elapsed,
                          builder: (context, elapsed, _) => StatusPill(
                            leading: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: _red,
                                shape: BoxShape.circle,
                              ),
                            ),
                            label: 'REC ${_format(elapsed)}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _aiSpeaking = !_aiSpeaking),
                          child: InterviewerAvatarCard(
                            speaking: _aiSpeaking,
                            // TODO(ai): put the interviewer avatar here.
                            avatar: null,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 34.h),
                Text(
                  _interviewerName,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brownText,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  _interviewerRole,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: _red,
                  ),
                ),
                SizedBox(height: 16.h),
                if (_captionsOn)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(20.w, 0, 20.w, 12.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Text(
                      // TODO(ai): live captions of what the interviewer says.
                      'Captions will appear here...',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12.sp,
                        color: AppColors.lightBrown,
                      ),
                    ),
                  ),
                ControlBar(
                  speakerOn: _speakerOn,
                  captionsOn: _captionsOn,
                  onSpeaker: () => setState(() => _speakerOn = !_speakerOn),
                  onCaptions: () => setState(() => _captionsOn = !_captionsOn),
                  onEnd: _confirmEnd,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
