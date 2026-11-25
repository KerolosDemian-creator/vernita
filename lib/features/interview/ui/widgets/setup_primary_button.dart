import 'package:flutter/material.dart';
import 'package:vernita/core/widgets/app_gradient_button.dart';

/// [AppGradientButton] with a clear disabled look.
/// Pass a null [onPressed] to disable it.
class SetupPrimaryButton extends StatelessWidget {
  const SetupPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.showArrow = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool showArrow;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: onPressed == null ? 0.45 : 1,
      duration: const Duration(milliseconds: 150),
      child: AppGradientButton(
        label: label,
        onPressed: onPressed,
        showArrow: showArrow,
      ),
    );
  }
}
