import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_gradient_button.dart';
import 'package:vernita/features/profile/profile/logic/profile_cubit.dart';
import 'package:vernita/features/profile/profile/logic/profile_field.dart';
import 'package:vernita/features/profile/profile/logic/profile_state.dart';

/// Opens a bottom sheet to edit one field. Saving calls the backend
/// (through ProfileCubit); the sheet closes only when the save succeeded.
Future<void> showEditFieldSheet(
  BuildContext context, {
  required ProfileField field,
  required String initial,
}) {
  context.read<ProfileCubit>().resetUpdateStatus();
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.warmCream,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
    ),
    builder: (_) => _EditFieldSheet(field: field, initial: initial),
  );
}

class _EditFieldSheet extends StatefulWidget {
  const _EditFieldSheet({required this.field, required this.initial});

  final ProfileField field;
  final String initial;

  @override
  State<_EditFieldSheet> createState() => _EditFieldSheetState();
}

class _EditFieldSheetState extends State<_EditFieldSheet> {
  late final _controller = TextEditingController(text: widget.initial);
  String? _localError; // our own validation (empty / too long)

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _save() {
    final value = _controller.text.trim();
    final error = widget.field.validate(value);
    if (error != null) {
      setState(() => _localError = error);
      return;
    }
    context.read<ProfileCubit>().updateField(widget.field, value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listenWhen: (previous, current) =>
          previous.updateStatus != current.updateStatus,
      listener: (context, state) {
        if (state.updateStatus == ProfileUpdateStatus.success) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final isSaving = state.updateStatus == ProfileUpdateStatus.saving;

        // Our validation message first, then the server's message.
        final errorText =
            _localError ??
            (state.updateStatus == ProfileUpdateStatus.failure
                ? state.errorMessage
                : null);

        return Padding(
          padding: EdgeInsets.fromLTRB(
            20.w,
            20.h,
            20.w,
            20.h + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit ${widget.field.label}',
                style: AppTextStyles.font16BrownPoppins600W,
              ),
              SizedBox(height: 14.h),
              TextField(
                controller: _controller,
                autofocus: true,
                enabled: !isSaving,
                maxLength: widget.field.maxLength,
                keyboardType: widget.field.keyboard,
                cursorColor: AppColors.lightPeachText,
                style: AppTextStyles.font13BrownPoppins600W,
                onChanged: (_) {
                  if (_localError != null) setState(() => _localError = null);
                },
                decoration: InputDecoration(
                  counterText: '',
                  filled: true,
                  fillColor: AppColors.fieldFill,
                  errorText: errorText,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 18.h),
              AppGradientButton(
                label: isSaving ? 'Saving...' : 'Save',
                onPressed: isSaving ? null : _save,
              ),
            ],
          ),
        );
      },
    );
  }
}
