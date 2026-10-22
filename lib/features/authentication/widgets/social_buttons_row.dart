import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/authentication/widgets/auth_text_field.dart';

class SocialButtonsRow extends StatelessWidget {
  const SocialButtonsRow({super.key, this.onApplePressed, this.onGooglePressed});

  final VoidCallback? onApplePressed;
  final VoidCallback? onGooglePressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          label: 'Apple',
          icon: Icon(Icons.apple, size: 22.r, color: AppColors.brownText),
          onTap: onApplePressed,
        ),
        SizedBox(width: 30.w),
        _SocialButton(
          label: 'Google',
          icon: _GoogleLogo(size: 20.r),
          onTap: onGooglePressed,
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.label, required this.icon, this.onTap});

  final String label;
  final Widget icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(20.r);
    return Container(
      width: 119.w,
      height: 52.h,
      decoration: authCardDecoration(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              SizedBox(width: 12.w),
              Text(label, style: AppTextStyles.font14BrownPoppins600W),
            ],
          ),
        ),
      ),
    );
  }
}

/// Google "G" drawn in code (no image/SVG asset needed).
class _GoogleLogo extends StatelessWidget {
  const _GoogleLogo({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  static const _blue = Color(0xFF4285F4);
  static const _green = Color(0xFF34A853);
  static const _yellow = Color(0xFFFBBC05);
  static const _red = Color(0xFFEA4335);

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width;
    final stroke = s * 0.2;
    final r = (s - stroke) / 2;
    final c = Offset(s / 2, s / 2);
    final rect = Rect.fromCircle(center: c, radius: r);

    double rad(double d) => d * math.pi / 180;
    Paint p(Color color) => Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;

    canvas.drawArc(rect, rad(0), rad(45), false, p(_blue));
    canvas.drawArc(rect, rad(45), rad(90), false, p(_green));
    canvas.drawArc(rect, rad(135), rad(80), false, p(_yellow));
    canvas.drawArc(rect, rad(215), rad(100), false, p(_red));

    canvas.drawRect(
      Rect.fromLTRB(c.dx, c.dy - stroke / 2, s, c.dy + stroke / 2),
      Paint()..color = _blue,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
