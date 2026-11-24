import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/analytics/performance/ui/widgets/recent_mock_interview_tile.dart';

class RecentMockInterviewsSection extends StatelessWidget {
  const RecentMockInterviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent Mock Interviews',
                maxLines: 2,
                style: AppTextStyles.font20BrownPoppins700W.copyWith(
                  fontSize: 18.sp,
                ),
              ),
            ),
            horizantalSpace(8),
            Text('See All', style: AppTextStyles.font13LightPeachPoppins700W),
            Icon(
              Icons.chevron_right_rounded,
              color: AppColors.lightPeachText,
              size: 18.r,
            ),
          ],
        ),
        verticalSpace(12),
        RecentMockInterviewTile(
          title: 'Senior Product Designer Mock',
          date: 'Aug 26',
          duration: '45 min',
          score: '84/100',
          techScore: '88',
          speechScore: '82',
          visionScore: '78',
          onTap: () => context.pushNamed(Routes.sessionAnalysis),
        ),
        verticalSpace(10),
        RecentMockInterviewTile(
          title: 'Full Stack Engineer Mock',
          date: 'Aug 20',
          duration: '35 min',
          score: '79/100',
          techScore: '80',
          speechScore: '76',
          visionScore: '82',
          onTap: () => context.pushNamed(Routes.sessionAnalysis),
        ),
      ],
    );
  }
}
