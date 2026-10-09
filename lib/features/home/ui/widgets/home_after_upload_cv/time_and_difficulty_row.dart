import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vernita/constants/constants.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class TimeAndDifficultyRow extends StatelessWidget {
  const TimeAndDifficultyRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.access_time_rounded, size: 20),
        horizantalSpace(6),
        Text('30 min', style: AppTextStyles.font12BrowPoppins700W),
        horizantalSpace(8),

        SizedBox(
          height: 40,
          child: VerticalDivider(
            thickness: .7,
            width: 5,
            indent: 12,
            endIndent: 12,
            color: Colors.red,
          ),
        ),
        horizantalSpace(8),

        SvgPicture.asset(AppSvgs.energyIcon),
        horizantalSpace(6),

        Text('Hard difficulty', style: AppTextStyles.font12BrowPoppins700W),
      ],
    );
  }
}
