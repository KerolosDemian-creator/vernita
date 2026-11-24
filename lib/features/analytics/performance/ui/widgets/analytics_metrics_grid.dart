import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/analytics_metric_card.dart';

class AnalyticsMetricsGrid extends StatelessWidget {
  const AnalyticsMetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: AnalyticsMetricCard(
                icon: Icons.star_border_rounded,
                value: '81/100',
                title: 'Overall Performance',
                improvement: '+16 pts improvement',
              ),
            ),
            horizantalSpace(12),
            const Expanded(
              child: AnalyticsMetricCard(
                icon: Icons.code_rounded,
                value: '88%',
                title: 'Technical Knowledge',
                description: 'Problem solving & system design',
              ),
            ),
          ],
        ),
        verticalSpace(10),
        Row(
          children: [
            const Expanded(
              child: AnalyticsMetricCard(
                icon: Icons.mic_none_rounded,
                value: '82%',
                title: 'Speech & Delivery',
                description: 'Clarity, pacing & 4 fillers/min',
              ),
            ),
            horizantalSpace(12),
            const Expanded(
              child: AnalyticsMetricCard(
                icon: Icons.camera_alt_outlined,
                value: '79%',
                title: 'Visual Presence (CV)',
                description: 'Eye contact, posture & calm',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
