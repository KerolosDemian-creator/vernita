import 'package:flutter/material.dart';

class AppColors {
  // =========================
  // Solid Colors
  // =========================

  static const Color brownText = Color(0xFF280F05);
  static const Color lightBrown = Color(0xFF4A3A32);

  static const Color lightPeachText = Color(0xFFDC8F5F);
  static const Color warmPeach = Color(0xFFFFEDD5);
  static const Color warmCream = Color(0xFFFEF5E8);

  static const Color wrongAlert = Color(0xFFEF4444);
  static const Color terracottaRed = Color(0xFFAD5A54);
  static const Color lightRed = Color(0xFFFCA5A5);
  static const Color blushPink = Color(0xFFFFDFD8);

  static const Color oliveForest = Color(0xFF3F5B24);
  static const Color greenAlert = Color(0xFF22C55E);
  static const Color lightGreen = Color(0xFFDFF3C0);

  static const Color greyText = Color(0xFF525252);
  static const Color personalTask = Color(0xFF9B51E0);
  static const Color textFieldText = Color(0xFFB1A399);
  static const Color white = Color(0xFFFEFBF5);

  // =========================
  // Gradient Colors
  // =========================

  // Mobile background
  static const Color backgroundPeach = Color(0xFFFDF3E8);
  static const Color backgroundCream = Color(0xFFFBE7D5);

  // Containers
  static const Color containerGradientEnd = Color(0xFFFFF7ED);

  // Buttons
  static const Color buttonGradientEnd = Color(0xFFFFB18C);

  // Upcoming mock
  static const Color upcomingMockGradientStart = Color(0xFFFEDFA1);
  static const Color upcomingMockGradientEnd = Color(0xFFFDB491);

  // Streak
  static const Color streakGradientStart = Color(0xFFFDEDC4);
  static const Color streakGradientEnd = Color(0xFFF6DEA0);

  // Mocks completed
  static const Color mocksCompletedGradientStart = Color(0xFFF4DDCA);
  static const Color mocksCompletedGradientEnd = Color(0xFFFBCBAB);

  // Target readiness
  static const Color targetReadinessGradientStart = Color(0xFFFBE4CD);
  static const Color targetReadinessGradientEnd = Color(0xFFF8C1A6);

  // Linear 2
  static const Color transparentLightPeach = Color(0x00DC8F5F);

  // =========================
  // Icons
  // =========================

  static const Color nonSelectedIcon = Color(0x663D1C00);
  static const Color selectedIcon = Color(0xFFF97316);

  // =========================
  // Gradients
  // =========================

  static const LinearGradient lightLinearBg = LinearGradient(
    colors: [backgroundPeach, backgroundCream],
  );

  static const LinearGradient containersGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [warmPeach, containerGradientEnd],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [lightPeachText, buttonGradientEnd],
  );

  static const LinearGradient upcomingMockContainerGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [upcomingMockGradientStart, upcomingMockGradientEnd],
  );

  static const LinearGradient streakContainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [streakGradientStart, streakGradientEnd],
  );

  static const LinearGradient mocksCompletedContainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [mocksCompletedGradientStart, mocksCompletedGradientEnd],
  );

  static const LinearGradient targetReadinessContainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [targetReadinessGradientStart, targetReadinessGradientEnd],
  );

  static const LinearGradient linear2 = LinearGradient(
    colors: [transparentLightPeach, buttonGradientEnd],
  );
}
