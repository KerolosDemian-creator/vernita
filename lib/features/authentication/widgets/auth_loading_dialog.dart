import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';

Future<void> showAuthLoadingDialog(BuildContext context) {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const Center(
      child: CircularProgressIndicator(color: AppColors.lightPeachText),
    ),
  );
}
