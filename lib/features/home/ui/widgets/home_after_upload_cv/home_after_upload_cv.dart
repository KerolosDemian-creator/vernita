import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/home_analysis_container.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/see_details_row.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/target_readiness_container.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/upcoming_mock_container.dart';

class HomeAfterUploadCv extends StatelessWidget {
  const HomeAfterUploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UpcomingMockContainer(),
        verticalSpace(20),
        SeeDetailsRow(),
        verticalSpace(13),

        Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: HomeAnalysisContainer(
                    containerIcon: SvgPicture.asset(AppSvgs.fireIcon),
                    txtInContaierIconRow: '+4%',
                    firstTxt: '4 Weeks',
                    secondTxt: 'Weekly Streak',
                    thirdTxt: '2 / 3 mocks this week',
                    containerColor: AppColors.steakContainerGradient,
                    bottomRow: Row(
                      children: [
                        SvgPicture.asset(AppSvgs.streakIcon),
                        horizantalSpace(5),
                        SvgPicture.asset(AppSvgs.streakIcon),
                        horizantalSpace(5),
                        SvgPicture.asset(AppSvgs.streakIcon),
                      ],
                    ),
                  ),
                ),
                horizantalSpace(12),
                Expanded(
                  child: HomeAnalysisContainer(
                    containerIcon: SvgPicture.asset(AppSvgs.fireIcon),
                    txtInContaierIconRow: '+2 this wk',
                    firstTxt: '14',
                    secondTxt: 'Mocks Completed',
                    thirdTxt: '8.5 hrs total practice',
                    containerColor: AppColors.mocksCompletedContainerGradient,
                    bottomRow: SizedBox.shrink(),
                  ),
                ),
              ],
            ),
            verticalSpace(14),
            TargetReadinessContainer(),
          ],
        ),
      ],
    );
  }
}
