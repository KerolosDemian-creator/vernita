import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';

class EmptyEventsCard extends StatelessWidget {
  const EmptyEventsCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      radius: 22,
      padding: EdgeInsets.symmetric(vertical: 22.h),
      child: Center(
        child: Text(message, style: AppTextStyles.font12GreyPoppins400W),
      ),
    );
  }
}
