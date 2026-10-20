import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../widgets/profile_gradient_button.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
import '../../logic/security_cubit.dart';
import '../../logic/security_state.dart';
import 'password_row.dart';

/// "CHANGE PASSWORD" card with 3 fields + Update Password button.
class ChangePasswordSection extends StatefulWidget {
  const ChangePasswordSection({super.key});

  @override
  State<ChangePasswordSection> createState() => _ChangePasswordSectionState();
}

class _ChangePasswordSectionState extends State<ChangePasswordSection> {
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _clear() {
    _currentController.clear();
    _newController.clear();
    _confirmController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SecurityCubit, SecurityState>(
      listenWhen: (p, c) =>
          p.status != c.status && c.status == SecurityStatus.passwordUpdated,
      listener: (context, state) => _clear(),
      builder: (context, state) {
        final cubit = context.read<SecurityCubit>();
        return Column(
          children: [
            const SectionLabel('Change Password'),
            SectionCard(
              children: [
                PasswordRow(
                  icon: Icons.lock_outline_rounded,
                  label: 'Current Password',
                  controller: _currentController,
                  obscure: state.obscureCurrent,
                  onToggle: () => cubit.toggleObscure(PasswordField.current),
                ),
                PasswordRow(
                  icon: Icons.vpn_key_outlined,
                  label: 'New Password',
                  controller: _newController,
                  obscure: state.obscureNew,
                  onToggle: () => cubit.toggleObscure(PasswordField.next),
                ),
                PasswordRow(
                  icon: Icons.shield_outlined,
                  label: 'Confirm New Password',
                  controller: _confirmController,
                  obscure: state.obscureConfirm,
                  onToggle: () => cubit.toggleObscure(PasswordField.confirm),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 14.h),
                  child: ProfileGradientButton(
                    label: 'Update Password',
                    onPressed: state.status == SecurityStatus.updating
                        ? null
                        : () => cubit.updatePassword(
                              current: _currentController.text,
                              newPassword: _newController.text,
                              confirm: _confirmController.text,
                            ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
