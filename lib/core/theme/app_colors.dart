import 'package:flutter/material.dart';

abstract final class AppColors {
  // Brand Colors
  static const Color lightPeachText = Color(0xFFDC8F5F);
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
  static const Color lightBrown = Color(0xFF4A3A32);
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
  static const Color terracottaRed = Color(0xFFAD5A54);
  static const Color lightRed = Color(0xFFFCA5A5);
  static const Color blushPink = Color(0xFFFFDFD8);

  static const Color oliveForest = Color(0xFF3F5B24);
  static const Color greenAlert = Color(0xFF22C55E);
  static const Color lightGreen = Color(0xFFDFF3C0);

  static const Color greyText = Color(0xFF525252);
  static const Color personalTask = Color(0xFF9B51E0);

  static const Color white = Color(0xFFFEFBF5);
  static const Color softBlush = Color(0xFFFEDCD8);
  static const Color paleApricot = Color(0xFFFEE6D0);
  static const Color softSage = Color(0xFFE5F4DA);
  static const Color pastelPeriwinkle = Color(0xFFCFDCF7);
  static const Color softLilac = Color(0xFFEBD2F5);
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
  static const Color softCoralPeach = Color(0xFFFEAA7A);
  static const Color vibrantCoral = Color(0xFFFE7461);
  // Streak
  static const Color streakGradientStart = Color(0xFFFDEDC4);
  static const Color streakGradientEnd = Color(0xFFF6DEA0);

  // Mocks completed
  static const Color mocksCompletedGradientStart = Color(0xFFF4DDCA);
  static const Color mocksCompletedGradientEnd = Color(0xFFFBCBAB);
  static const Color softApricot = Color(0xFFFEEAD2);
  // Target readiness
  static const Color targetReadinessGradientStart = Color(0xFFFBE4CD);
  static const Color targetReadinessGradientEnd = Color(0xFFF8C1A6);

  // Linear 2
  static const Color transparentLightPeach = Color(0x00DC8F5F);

  // =========================
  // Icons
  // =========================

  //static Color selectedIcon = Color(0xffF97316); // 10% opacity

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
  static const LinearGradient analyticsIconContainerGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [softCoralPeach, vibrantCoral],
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
