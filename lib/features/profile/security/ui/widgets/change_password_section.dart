import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import '../../../widgets/profile_gradient_button.dart';
import '../../../widgets/section_card.dart';
import '../../../widgets/section_label.dart';
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

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SectionLabel('Change Password'),
        SectionCard(
          children: [
            PasswordRow(
              icon: Icons.lock_outline_rounded,
              label: 'Current Password',
              controller: _currentController,
              obscure: _obscureCurrent,
              onToggle: () =>
                  setState(() => _obscureCurrent = !_obscureCurrent),
            ),
            PasswordRow(
              icon: Icons.vpn_key_outlined,
              label: 'New Password',
              controller: _newController,
              obscure: _obscureNew,
              onToggle: () => setState(() => _obscureNew = !_obscureNew),
            ),
            PasswordRow(
              icon: Icons.shield_outlined,
              label: 'Confirm New Password',
              controller: _confirmController,
              obscure: _obscureConfirm,
              onToggle: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 6.h, 14.w, 14.h),
              child: ProfileGradientButton(
                label: 'Update Password',
                onPressed: () {}, // TODO(backend): change-password endpoint
              ),
            ),
          ],
        ),
      ],
    );
  }
}
