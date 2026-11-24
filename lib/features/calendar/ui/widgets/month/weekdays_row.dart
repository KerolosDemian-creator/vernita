import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/features/calendar/logic/calendar_utils.dart';

/// S M T W T F S
class WeekdaysRow extends StatelessWidget {
  const WeekdaysRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final letter in weekdayLetters)
          Expanded(
            child: Center(
              child: Text(letter, style: AppTextStyles.font11GreyPoppins400W),
            ),
          ),
      ],
    );
  }
}
