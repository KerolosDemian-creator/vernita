import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/interview_session/ui/widgets/speaking_pill.dart';

/// Big rounded card that holds the interviewer.
/// [avatar] is the slot for the AI avatar; when null, an anonymous
/// placeholder is shown instead.
class InterviewerAvatarCard extends StatelessWidget {
  const InterviewerAvatarCard({required this.speaking, this.avatar});

  final bool speaking;
  final Widget? avatar;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(56.r);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFFFD39A), Color(0xFFFB9C5C)],
              ),
              borderRadius: radius,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.7),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.buttonShadow,
                  blurRadius: 30,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(52.r),
              child: avatar ?? const AvatarPlaceholder(),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: -18.h,
          child: Center(child: SpeakingPill(active: speaking)),
        ),
      ],
    );
  }
}

/// Anonymous "unknown person" shown until the AI avatar is connected.
class AvatarPlaceholder extends StatefulWidget {
  const AvatarPlaceholder();

  @override
  State<AvatarPlaceholder> createState() => _AvatarPlaceholderState();
}

class _AvatarPlaceholderState extends State<AvatarPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 2200),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: Tween<double>(begin: 0.96, end: 1.04).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
        ),
        child: FractionallySizedBox(
          widthFactor: 0.6,
          heightFactor: 0.6,
          child: FittedBox(
            child: Icon(
              Icons.person_rounded,
              size: 200,
              color: Colors.white.withValues(alpha: 0.6),
            ),
          ),
        ),
      ),
    );
  }
}
