import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

class NotificationDateHeader extends StatelessWidget {
  const NotificationDateHeader({super.key, required this.sectionTile});
  final String sectionTile;
  @override
  Widget build(BuildContext context) {
    return Text(sectionTile, style: AppTextStyles.font12BrowPoppins700W);
  }
}
