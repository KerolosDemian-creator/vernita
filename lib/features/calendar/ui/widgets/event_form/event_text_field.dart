import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/helper/spacing.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import 'package:vernita/core/widgets/icon_box.dart';

/// Rounded card with a leading icon box and a borderless text field.
/// - [showPaste]: small purple button that pastes from the clipboard.
/// - [maxLength]: shows a "0/200" counter at the bottom right.
class EventTextField extends StatelessWidget {
  const EventTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.icon,
    this.maxLines = 1,
    this.maxLength,
    this.showPaste = false,
  });

  final TextEditingController controller;
  final String hint;
  final IconData icon;
  final int maxLines;
  final int? maxLength;
  final bool showPaste;

  Future<void> _paste() async {
    final data = await Clipboard.getData(Clipboard.kTextPlain);
    final text = data?.text;
    if (text == null || text.isEmpty) return;
    controller.text = maxLength == null || text.length <= maxLength!
        ? text
        : text.substring(0, maxLength);
  }

  @override
  Widget build(BuildContext context) {
    final multiLine = maxLines > 1;

    return AppCard(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                multiLine ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              IconBox(icon: icon),
              horizantalSpace(10),
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: maxLines,
                  minLines: multiLine ? maxLines : 1,
                  maxLength: maxLength,
                  style: AppTextStyles.font12BrownPoppins600W.copyWith(
                    letterSpacing: 0,
                  ),
                  cursorColor: AppColors.lightPeachText,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    filled: false,
                    counterText: '',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10.h),
                    hintText: hint,
                    hintStyle: AppTextStyles.font12GreyPoppins400W.copyWith(
                      color: AppColors.textFieldText,
                    ),
                  ),
                ),
              ),
              if (showPaste)
                GestureDetector(
                  onTap: _paste,
                  child: Container(
                    width: 30.r,
                    height: 30.r,
                    decoration: BoxDecoration(
                      color: AppColors.violetBg,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.content_paste_rounded,
                      size: 16.r,
                      color: AppColors.personalTask,
                    ),
                  ),
                ),
            ],
          ),
          if (maxLength != null)
            Align(
              alignment: Alignment.bottomRight,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (_, value, __) => Text(
                  '${value.text.length}/$maxLength',
                  style: AppTextStyles.font10LightBrownPoppins600W.copyWith(
                    color: AppColors.textFieldText,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
