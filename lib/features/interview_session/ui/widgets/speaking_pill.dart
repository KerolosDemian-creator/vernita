import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';

/// Small white pill with the sound wave, shown over the avatar's bottom edge.
class SpeakingPill extends StatelessWidget {
  const SpeakingPill({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: const [
          BoxShadow(
            color: AppColors.fieldShadow,
            blurRadius: 14,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: SoundWave(active: active),
    );
  }
}

class SoundWave extends StatefulWidget {
  const SoundWave({required this.active});

  final bool active;

  @override
  State<SoundWave> createState() => _SoundWaveState();
}

class _SoundWaveState extends State<SoundWave>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bars = 4;
    final maxHeight = 16.h;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            for (var i = 0; i < bars; i++)
              Container(
                margin: EdgeInsets.symmetric(horizontal: 1.5.w),
                width: 3.w,
                height: widget.active
                    ? maxHeight *
                          (0.35 +
                              0.65 *
                                  math
                                      .sin(
                                        _controller.value * 2 * math.pi +
                                            i * 0.9,
                                      )
                                      .abs())
                    : maxHeight * 0.3,
                decoration: BoxDecoration(
                  color: AppColors.lightPeachText,
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
          ],
        );
      },
    );
  }
}
