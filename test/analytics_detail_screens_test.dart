import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/features/analytics/interview_questions_feedback/ui/interview_questions_feedback_screen.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/recent_mock_interviews_section.dart';
import 'package:vernita/features/analytics/session_analysis/ui/session_analysis_screen.dart';
import 'package:vernita/features/analytics/skill_breakdown/ui/detailed_skill_breakdown_screen.dart';

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

Future<void> _pumpScreen(WidgetTester tester, Widget home) async {
  tester.view.physicalSize = const Size(375, 812);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ScreenUtilPlusInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (_, child) =>
          MaterialApp(home: home, onGenerateRoute: AppRouter().generateRoute),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Session Analysis renders without overflow', (tester) async {
    await _loadPoppins();
    await _pumpScreen(tester, const SessionAnalysisScreen());

    expect(find.text('Session Analysis'), findsOneWidget);
    expect(find.text('OVERALL SCORE'), findsOneWidget);
    expect(find.text('Skill Breakdown'), findsOneWidget);
    expect(find.text('Interview Questions & Feedback'), findsOneWidget);
    expect(find.text('Try to be more specific'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Detailed Skill Breakdown renders without overflow', (
    tester,
  ) async {
    await _loadPoppins();
    await _pumpScreen(tester, const DetailedSkillBreakdownScreen());

    expect(find.text('Detailed Skill Breakdown'), findsOneWidget);
    expect(find.text('Technical Skills'), findsOneWidget);
    expect(find.text('Problem Solving'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Interview feedback renders all questions and answer player', (
    tester,
  ) async {
    await _loadPoppins();
    await _pumpScreen(tester, const InterviewQuestionsFeedbackScreen());

    expect(find.text('Interview Questions & Feedback'), findsOneWidget);
    expect(
      find.text('How would you design a scalable chat application?'),
      findsOneWidget,
    );
    expect(find.text('01:45'), findsOneWidget);
    expect(find.byIcon(Icons.play_arrow_outlined), findsOneWidget);
    expect(find.text('AI Feedback'), findsOneWidget);
    expect(find.text('How would you ensure data consistency?'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Recent mock tile opens Session Analysis', (tester) async {
    await _loadPoppins();
    await _pumpScreen(
      tester,
      const Scaffold(
        body: SingleChildScrollView(child: RecentMockInterviewsSection()),
      ),
    );

    await tester.tap(find.text('Senior Product Designer Mock'));
    await tester.pumpAndSettle();

    expect(find.text('Session Analysis'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Session Analysis View All opens Detailed Skill Breakdown', (
    tester,
  ) async {
    await _loadPoppins();
    await _pumpScreen(tester, const SessionAnalysisScreen());

    await tester.tap(find.text('View All').first);
    await tester.pumpAndSettle();

    expect(find.text('Detailed Skill Breakdown'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Session Analysis questions View All opens feedback', (
    tester,
  ) async {
    await _loadPoppins();
    await _pumpScreen(tester, const SessionAnalysisScreen());

    final viewAll = find.text('View All').last;
    await tester.ensureVisible(viewAll);
    await tester.pumpAndSettle();
    await tester.tap(viewAll);
    await tester.pumpAndSettle();

    expect(find.text('Interview Questions & Feedback'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('Session Analysis question opens Interview Feedback', (
    tester,
  ) async {
    await _loadPoppins();
    await _pumpScreen(tester, const SessionAnalysisScreen());

    final question = find.text('What are your strengths and weaknesses?');
    await tester.ensureVisible(question);
    await tester.pumpAndSettle();
    await tester.tap(question);
    await tester.pumpAndSettle();

    expect(find.text('Interview Questions & Feedback'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
