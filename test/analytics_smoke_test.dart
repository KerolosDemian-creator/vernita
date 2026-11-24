import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/analytics_body.dart';

Future<void> _loadPoppins() async {
  final loader = FontLoader('Poppins');
  for (final path in [
    'lib/core/utils/fonts/Poppins-Regular.ttf',
    'lib/core/utils/fonts/Poppins-Medium.ttf',
    'lib/core/utils/fonts/Poppins-SemiBold.ttf',
    'lib/core/utils/fonts/Poppins-Bold.ttf',
  ]) {
    final bytes = File(path).readAsBytesSync();
    loader.addFont(Future<ByteData>.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

void main() {
  testWidgets('Analytics renders at 390x844 without overflow', (tester) async {
    await _loadPoppins();
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ScreenUtilPlusInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        ensureScreenSize: true,
        builder: (_, child) =>
            const MaterialApp(home: Scaffold(body: AnalyticsBody())),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Performance Analytics'), findsOneWidget);
    expect(find.text('81/100'), findsOneWidget);
    expect(find.text('Senior Product Designer Mock'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
