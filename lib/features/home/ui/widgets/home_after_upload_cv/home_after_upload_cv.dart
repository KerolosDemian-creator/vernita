import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/see_details_row.dart';
import 'package:vernita/features/home/ui/widgets/home_after_upload_cv/upcoming_mock_container.dart';

class HomeAfterUploadCv extends StatelessWidget {
  const HomeAfterUploadCv({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [UpcomingMockContainer(), verticalSpace(20), SeeDetailsRow()],
    );
  }
}
