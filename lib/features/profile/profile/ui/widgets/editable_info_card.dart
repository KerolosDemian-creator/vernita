import 'package:flutter/material.dart';
import '../../../widgets/info_tile.dart';
import '../../../widgets/section_card.dart';
import '../../data/models/user_model.dart';
import '../../logic/profile_field.dart';
import 'editable_info_tile.dart';

/// Rows shown on the Personal Information screen.
/// Specialization and phone can be edited, the email can't (backend rule).
class EditableInfoCard extends StatelessWidget {
  const EditableInfoCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        EditableInfoTile(
          icon: Icons.badge_outlined,
          field: ProfileField.specialization,
          user: user,
        ),
        InfoTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email Address',
          value: user.email,
        ),
        EditableInfoTile(
          icon: Icons.phone_outlined,
          field: ProfileField.phone,
          user: user,
          label: 'Phone',
        ),
      ],
    );
  }
}
