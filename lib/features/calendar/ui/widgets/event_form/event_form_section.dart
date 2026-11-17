import 'package:flutter/material.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// Label on top + the input under it.
class EventFormSection extends StatelessWidget {
  const EventFormSection({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.font13BrownPoppins600W),
        verticalSpace(8),
        child,
        verticalSpace(18),
      ],
    );
  }
}
