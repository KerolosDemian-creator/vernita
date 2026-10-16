import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Colors
  static const Color primary = Color(0xFFDC8F5F);
  static const Color background = Color(0xFF181616);

  // Light Theme Colors
  static const Color beige = Color(0xFFFBE7D5);

  // Button Gradient
  static const Color lightPeach = Color(0xFFFFDCC2);
  static const Color peach = Color(0xFFFFB18C);

  // Icon Colors
  static const Color nonSelectedIcon = Color(0x663D1C00); // 40% opacity

  static const Color selectedIcon = Color(0x1AF97316); // 10% opacity

  // Text Field
  static const Color textFieldText = Color(0xFFB1A399);

  // ---- Added for Auth screens ----

  // Text
  static const Color brownText = Color(0xFF280F05);
  static const Color lightBrownText = Color(0xFF4A3A32);

  // Auth background gradient (top -> bottom). Bottom is [beige].
  static const Color authGradientTop = Color(0xFFFDF3E8);

  // Cards / fields
  static const Color fieldFill = Color(0xFFFEF8F4);
  static const Color fieldShadow = Color(0x14DCA082); // rgba(220,160,130,.08)

  // Primary button shadow
  static const Color buttonShadow = Color(0x61E68C5F); // rgba(230,140,95,.38)

  // Tab switcher
  static const Color tabBackground = Color(0xCCF8E5D5); // rgba(248,229,213,.8)
  static const Color tabSelectedStart = Color(0xFFFDCF95);
  static const Color tabSelectedEnd = Color(0xFFFDCCB7);

  // Header badge (avatar / lock box)
  static const Color badgeStart = Color(0xFFFFEEE1);
  static const Color badgeEnd = Color(0xFFFCDCC8);
  static const Color badgeShadow = Color(0x40B4785A);


  static const Color warmPeach = Color(0xFFFFEDD5);
  static const Color warmCream = Color(0xFFFEF5E8);

  static const Color wrongAlert = Color(0xFFEF4444);
  static const Color lightRed = Color(0xFFFCA5A5);

  static const Color greenAlert = Color(0xFF22C55E);

  static const Color greyText = Color(0xFF525252);

  static const Color personalTask = Color(0xFF9B51E0);

  static const Color white = Color(0xFFFEFBF5);

  // =========================
  // Icons
  // =========================


  //static Color selectedIcon = Color(0xffF97316); // 10% opacity

  // =========================
  // Gradients
  // =========================

  // Mobile background
  static const LinearGradient lightLinearBg = LinearGradient(
    colors: [Color(0xFFFDF3E8), Color(0xFFFBE7D5)],
  );

  static const LinearGradient containersGradient = LinearGradient(
    begin: AlignmentGeometry.topCenter,
    end: AlignmentGeometry.bottomCenter,
    colors: [Color(0xFFFFEDD5), Color(0xFFFFF7ED)],
  );
  static const LinearGradient buttonGradient = LinearGradient(
    begin: AlignmentGeometry.centerLeft,
    end: AlignmentGeometry.centerRight,
    colors: [AppColors.primary, Color(0xFFFFB18C)],
  );

  // Button gradient
  static const LinearGradient linear2 = LinearGradient(
    colors: [Color(0x00DC8F5F), Color(0xFFFFB18C)],
  );
}
