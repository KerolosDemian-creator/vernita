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
  static const Color lightGreeen = Color(0xFFDFF3C0);

  static const Color greyText = Color(0xFF525252);

  static const Color personalTask = Color(0xFF9B51E0);

  static const Color textFieldText = Color(0xFFB1A399);
  static const Color white = Color(0xFFFEFBF5);

  // =========================
  // Icons
  // =========================

  static const Color nonSelectedIcon = Color(0x663D1C00); // 40% opacity

  static Color selectedIcon = Color(0xffF97316); // 10% opacity

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
    colors: [AppColors.lightPeachText, Color(0xFFFFB18C)],
  );

  // Upcoming mock container gradient
  static const LinearGradient upcomingMockContainerGradient = LinearGradient(
    begin: AlignmentGeometry.centerLeft,
    end: AlignmentGeometry.centerRight,
    colors: [Color(0xffFEDFA1), Color(0xFFFDB491)],
  );

  // Streak container gradient
  static const LinearGradient steakContainerGradient = LinearGradient(
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
    colors: [Color(0xffFDEDC4), Color(0xFFF6DEA0)],
  );
  static const LinearGradient mocksCompletedContainerGradient = LinearGradient(
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
    colors: [Color(0xffF4DDCA), Color(0xFFFBCBAB)],
  );
  static const LinearGradient targetReadinessContainerGradient = LinearGradient(
    begin: AlignmentGeometry.topLeft,
    end: AlignmentGeometry.bottomRight,
    colors: [Color(0xffFBE4CD), Color(0xFFF8C1A6)],
  );

  // Button gradient
  static const LinearGradient linear2 = LinearGradient(
    colors: [Color(0x00DC8F5F), Color(0xFFFFB18C)],
  );
}
