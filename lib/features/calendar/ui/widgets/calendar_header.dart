import 'package:flutter/material.dart';
import 'package:vernita/core/helper/extensions.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/round_icon_button.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Calendar', style: AppTextStyles.font28BrownPoppins700W),
              verticalSpace(2),
              Text(
                'Manage your interview sessions and tasks',
                style: AppTextStyles.font12GreyPoppins400W,
              ),
            ],
          ),
        ),
        RoundIconButton(
          icon: Icons.add_rounded,
          onTap: () => context.pushNamed(Routes.addEvent),
        ),
      ],
    );
  }
}
