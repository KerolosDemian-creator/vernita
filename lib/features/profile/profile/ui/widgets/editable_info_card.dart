import 'package:flutter/material.dart';
import '../../../widgets/info_tile.dart';
import '../../../widgets/section_card.dart';
import '../../data/models/user_model.dart';

/// Tappable rows shown on the Personal Information screen.
class EditableInfoCard extends StatelessWidget {
  const EditableInfoCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      children: [
        InfoTile(
          icon: Icons.badge_outlined,
          label: 'Specialization',
          value: user.specialization,
          showChevron: true,
          onTap: () {}, // TODO: edit specialization
        ),
        InfoTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email Address',
          value: user.email,
          showChevron: true,
          onTap: () {}, // TODO: edit email
        ),
        InfoTile(
          icon: Icons.phone_outlined,
          label: 'Phone',
          value: user.phone,
          showChevron: true,
          onTap: () {}, // TODO: edit phone
        ),
        InfoTile(
          icon: Icons.language_rounded,
          label: 'Location',
          value: user.location,
          showChevron: true,
          onTap: () {}, // TODO: edit location
        ),
      ],
    );
  }
}
