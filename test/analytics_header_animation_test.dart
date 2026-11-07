import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/analytics_header.dart';

void main() {
  testWidgets('period pill collapses, expands on tap, and repeats', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var isVisible = false;
    late StateSetter setVisibility;

    await tester.pumpWidget(
      StatefulBuilder(
        builder: (context, setState) {
          setVisibility = setState;
          return ScreenUtilPlusInit(
            designSize: const Size(375, 812),
            splitScreenMode: true,
            ensureScreenSize: true,
            builder: (_, child) => MaterialApp(
              home: Scaffold(
                body: Center(
                  child: SizedBox(
                    width: 390,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TickerMode(
                        enabled: isVisible,
                        child: const AnalyticsHeader(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    final pill = find.byKey(const ValueKey('analytics-period-pill'));
    double pillWidth() => tester.getSize(pill).width;
    double fadeOpacity(String label) {
      final animate = find
          .ancestor(of: find.text(label), matching: find.byType(Animate))
          .first;
      final fade = find
          .descendant(of: animate, matching: find.byType(FadeTransition))
          .first;
      return tester.widget<FadeTransition>(fade).opacity.value;
    }

    double fullOpacity() => fadeOpacity('Last 30 Days');
    double compactOpacity() => fadeOpacity('30');

    await tester.pump(const Duration(seconds: 4));

    final fullWidth = pillWidth();
    expect(fullWidth, greaterThan(90));
    expect(fullOpacity(), closeTo(1, 0.01));
    expect(compactOpacity(), closeTo(0, 0.01));

    setVisibility(() => isVisible = true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2300));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pump(const Duration(milliseconds: 700));
    final compactWidth = pillWidth();
    expect(compactWidth, lessThan(fullWidth - 30));
    expect(fullOpacity(), closeTo(0, 0.01));
    expect(compactOpacity(), closeTo(1, 0.01));

    await tester.tap(pill);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(fullWidth, 0.1));
    expect(fullOpacity(), closeTo(1, 0.01));
    expect(compactOpacity(), closeTo(0, 0.01));

    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(compactWidth, 0.1));

    await tester.tap(pill);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(compactWidth, 0.1));

    await tester.tap(pill);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    setVisibility(() => isVisible = false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    setVisibility(() => isVisible = true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 2300));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    await tester.pump(const Duration(milliseconds: 2400));
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(compactWidth, 0.1));

    setVisibility(() => isVisible = false);
    await tester.pump();
    await tester.pump(const Duration(seconds: 4));
    expect(pillWidth(), closeTo(compactWidth, 0.1));

    setVisibility(() => isVisible = true);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 700));
    expect(pillWidth(), closeTo(fullWidth, 0.1));

    expect(tester.takeException(), isNull);
  });
}
