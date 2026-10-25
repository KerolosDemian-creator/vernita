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
    required this.controller,
    this.keyboardType,
    this.textInputAction,
    this.isPassword = false,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.autovalidateMode,
  });   

  final String hint;
  final IconData icon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 55.h),
      decoration: authCardDecoration(),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword && _obscure,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onFieldSubmitted,
        autovalidateMode: widget.autovalidateMode,
        cursorColor: AppColors.lightPeachText,
        style: AppTextStyles.font15BrownPoppins400W,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 16.h),
          hintText: widget.hint,
          hintStyle: AppTextStyles.font15GreyPoppins400W,
          errorStyle: TextStyle(fontSize: 11.sp, color: Colors.redAccent),
          prefixIcon: Padding(
            padding: EdgeInsets.only(left: 17.w, right: 14.w),
            child: Container(
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
          ),
          prefixIconConstraints: const BoxConstraints(),
          suffixIcon: widget.isPassword
              ? Padding(
                  padding: EdgeInsets.only(right: 13.w),
                  child: GestureDetector(
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
                )
              : null,
          suffixIconConstraints: const BoxConstraints(),
        ),
      ),
    );
  }
}
