import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';

/// Shadowed field container reused by text fields and cards.
BoxDecoration authCardDecoration({double radius = 20}) => BoxDecoration(
      color: AppColors.fieldFill,
      borderRadius: BorderRadius.circular(radius.r),
      border: Border.all(color: AppColors.fieldFill),
      boxShadow: const [
        BoxShadow(
          color: AppColors.fieldShadow,
          offset: Offset(0, 4),
          blurRadius: 20,
          spreadRadius: -2,
        ),
        BoxShadow(
          color: Color(0x05000000),
          offset: Offset(0, 2),
          blurRadius: 6,
          spreadRadius: -1,
        ),
      ],
    );

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.hint,
    required this.icon,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
  });

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      padding: EdgeInsets.symmetric(horizontal: 17.w),
      decoration: authCardDecoration(),
      child: Row(
        children: [
          Container(
            width: 36.r,
            height: 36.r,
            decoration: BoxDecoration(
              color: AppColors.selectedIcon,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              widget.icon,
              size: 19.r,
              color: AppColors.nonSelectedIcon,
            ),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: TextField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              textInputAction: widget.textInputAction,
              obscureText: widget.isPassword && _obscure,
              cursorColor: AppColors.primary,
              style: AppTextStyles.fieldText,
              decoration: InputDecoration(
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: AppTextStyles.fieldHint,
              ),
            ),
          ),
          if (widget.isPassword)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => setState(() => _obscure = !_obscure),
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  size: 21.r,
                  color: AppColors.nonSelectedIcon,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
