import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class SeeDetailsRow extends StatelessWidget {
  const SeeDetailsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Your Progress', style: AppTextStyles.font18BrownPoppins700W),
        Spacer(),
        Row(
          children: [
            Text(
              'See details',
              style: AppTextStyles.font13LightPeachPoppins600W,
            ),

            Icon(
              Icons.arrow_forward,
              color: AppColors.lightPeachText,
              size: 19,
            ),
          ],
        ),
      ],
    );
  }
}
