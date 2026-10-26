import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/features/authentication/widgets/auth_error_dialog.dart';

Widget _testApp({required String message}) {
  return ScreenUtilPlusInit(
    designSize: const Size(375, 812),
    splitScreenMode: true,
    ensureScreenSize: true,
    builder: (context, child) => MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (_) =>
                    AuthErrorDialog(title: 'Login Failed', message: message),
              ),
              child: const Text('Show error'),
            ),
          ),
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('renders the error content and dismisses with Got it', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(_testApp(message: 'Invalid email or password.'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show error'));
    await tester.pumpAndSettle();

    expect(find.text('Login Failed'), findsOneWidget);
    expect(find.text('Invalid email or password.'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline_rounded), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Got it'));
    await tester.pumpAndSettle();

    expect(find.text('Login Failed'), findsNothing);
    expect(find.text('Show error'), findsOneWidget);
  });

  testWidgets('handles long messages without overflow on a smaller screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final longMessage = List.filled(
      30,
      'The server could not complete your request. Please try again.',
    ).join(' ');

    await tester.pumpWidget(_testApp(message: longMessage));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Show error'));
    await tester.pumpAndSettle();

    expect(find.text('Login Failed'), findsOneWidget);
    expect(find.text('Got it'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
