import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

const _fullPeriod = 'Last 30 Days';
const _compactPeriod = '30';

class AnalyticsHeader extends StatelessWidget {
  const AnalyticsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final periodStyle = AppTextStyles.font13LightPeachPoppins600W;
    final textScaler = MediaQuery.textScalerOf(context);
    final fullPillWidth =
        _textWidth(
          _fullPeriod,
          periodStyle,
          textScaler,
          Directionality.of(context),
        ) +
        24.w;
    final compactPillWidth =
        _textWidth(
          _compactPeriod,
          periodStyle,
          textScaler,
          Directionality.of(context),
        ) +
        24.w;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              'Performance Analytics',
              maxLines: 1,
              style: AppTextStyles.font20BrownPoppins700W,
            ),
          ),
        ),
        horizantalSpace(8),
        SizedBox(
          width: fullPillWidth,
          child: Align(
            alignment: Alignment.centerRight,
            child: _AnimatedPeriodPill(
              periodStyle: periodStyle,
              fullWidth: fullPillWidth,
              compactWidth: compactPillWidth,
            ),
          ),
        ),
      ],
    );
  }

  double _textWidth(
    String text,
    TextStyle style,
    TextScaler textScaler,
    TextDirection textDirection,
  ) {
    final painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: textDirection,
      textScaler: textScaler,
    )..layout();

    return painter.width;
  }
}

class _AnimatedPeriodPill extends StatefulWidget {
  const _AnimatedPeriodPill({
    required this.periodStyle,
    required this.fullWidth,
    required this.compactWidth,
  });

  final TextStyle periodStyle;
  final double fullWidth;
  final double compactWidth;

  @override
  State<_AnimatedPeriodPill> createState() => _AnimatedPeriodPillState();
}

class _AnimatedPeriodPillState extends State<_AnimatedPeriodPill> {
  static const _pillKey = ValueKey('analytics-period-pill');
  static const _collapseDelay = Duration(milliseconds: 2000);
  static const _animationDuration = Duration(milliseconds: 500);

  late final ValueNotifier<bool> _isCompact;
  Timer? _collapseTimer;
  bool? _wasTickerEnabled;

  @override
  void initState() {
    super.initState();
    _isCompact = ValueNotifier<bool>(false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // TickerMode changes when the Analytics tab is shown or hidden.
    final tickerEnabled = TickerMode.valuesOf(context).enabled;
    if (_wasTickerEnabled == tickerEnabled) {
      return;
    }

    _wasTickerEnabled = tickerEnabled;
    if (tickerEnabled) {
      _activate();
    } else {
      _collapseTimer?.cancel();
    }
  }

  void _activate() {
    _collapseTimer?.cancel();
    _isCompact.value = false;
    _scheduleCollapse();
  }

  void _scheduleCollapse() {
    // Always replace the previous timer, so every tap gets a fresh delay.
    _collapseTimer?.cancel();
    _collapseTimer = Timer(_collapseDelay, () {
      if (!mounted) {
        return;
      }

      _isCompact.value = true;
    });
  }

  void _expand() {
    if (!_isCompact.value) {
      return;
    }

    // Cancel the pending collapse before starting the expand animation.
    _collapseTimer?.cancel();
    _isCompact.value = false;
    _scheduleCollapse();
  }

  @override
  void dispose() {
    _collapseTimer?.cancel();
    _isCompact.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isCompact,
      builder: (context, isCompact, child) {
        return Semantics(
          button: isCompact,
          label: isCompact ? 'Last 30 Days. Tap to expand' : 'Last 30 Days',
          onTap: isCompact ? _expand : null,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            excludeFromSemantics: true,
            onTap: isCompact ? _expand : null,
            child: ExcludeSemantics(
              child: AnimatedContainer(
                key: _pillKey,
                width: isCompact ? widget.compactWidth : widget.fullWidth,
                duration: _animationDuration,
                curve: Curves.easeInOutCubic,
                padding: EdgeInsets.symmetric(vertical: 4.h),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.fieldFill,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Both labels stay mounted so flutter_animate can
                    // crossfade and scale them while the pill width
                    // animates.
                    Text(
                          _fullPeriod,
                          maxLines: 1,
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: widget.periodStyle,
                        )
                        .animate(target: isCompact ? 1.0 : 0.0)
                        .fade(
                          begin: 1,
                          end: 0,
                          duration: _animationDuration,
                          curve: Curves.easeInOutCubic,
                        )
                        .scale(
                          begin: const Offset(1, 1),
                          end: const Offset(0.94, 0.94),
                          duration: _animationDuration,
                          curve: Curves.easeInOutCubic,
                        ),
                    Text(
                          _compactPeriod,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: widget.periodStyle,
                        )
                        .animate(target: isCompact ? 1.0 : 0.0)
                        .fade(
                          begin: 0,
                          end: 1,
                          duration: _animationDuration,
                          curve: Curves.easeInOutCubic,
                        )
                        .scale(
                          begin: const Offset(0.92, 0.92),
                          end: const Offset(1, 1),
                          duration: _animationDuration,
                          curve: Curves.easeInOutCubic,
                        ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
