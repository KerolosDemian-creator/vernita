import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/ai_insights_card.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/analytics_header.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/analytics_metrics_grid.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/recent_mock_interviews_section.dart';

class AnalyticsBody extends StatelessWidget {
  const AnalyticsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AnalyticsHeader(),
            verticalSpace(18),
            const AnalyticsMetricsGrid(),
            verticalSpace(14),
            const AiInsightsCard(),
            verticalSpace(24),
            const RecentMockInterviewsSection(),
          ],
        ),
      ),
    );
  }
}
