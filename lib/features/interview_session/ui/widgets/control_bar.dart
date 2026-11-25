import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

/// Bottom bar: speaker, end interview, captions.
class ControlBar extends StatelessWidget {
  const ControlBar({
    required this.speakerOn,
    required this.captionsOn,
    required this.onSpeaker,
    required this.onCaptions,
    required this.onEnd,
  });

  final bool speakerOn;
  final bool captionsOn;
  final VoidCallback onSpeaker;
  final VoidCallback onCaptions;
  final VoidCallback onEnd;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 18.h, 24.w, 0),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ControlButton(
                icon: speakerOn
                    ? Icons.volume_up_rounded
                    : Icons.volume_off_rounded,
                label: 'Speaker',
                active: speakerOn,
                onTap: onSpeaker,
              ),
              ControlButton(
                icon: Icons.close_rounded,
                label: 'End Interview',
                danger: true,
                onTap: onEnd,
              ),
              ControlButton(
                icon: Icons.closed_caption_rounded,
                label: 'Captions',
                active: captionsOn,
                onTap: onCaptions,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ControlButton extends StatelessWidget {
  const ControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
    this.danger = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool active;
  final bool danger;

  @override
  Widget build(BuildContext context) {
    final size = danger ? 60.r : 48.r;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: 90.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: danger
                    ? const Color(0xFFEF4444)
                    : active
                    ? AppColors.tabSelectedStart
                    : AppColors.paleApricot,
                boxShadow: danger
                    ? [
                        BoxShadow(
                          color: const Color(0xFFEF4444).withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ]
                    : null,
              ),
              child: Icon(
                icon,
                size: danger ? 28.r : 22.r,
                color: danger ? Colors.white : AppColors.lightBrown,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11.sp,
                fontWeight: danger ? FontWeight.w700 : FontWeight.w500,
                color: danger ? AppColors.brownText : AppColors.lightBrown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
