import 'package:flutter/material.dart';
import '../../../widgets/info_tile.dart';
import '../../../widgets/section_card.dart';
import '../../data/models/user_model.dart';

/// Read-only summary shown on the main Profile screen.
class PersonalInfoCard extends StatelessWidget {
  const PersonalInfoCard({super.key, required this.user});

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Personal Information',
      children: [
        InfoTile(
          icon: Icons.person_outline_rounded,
          label: 'Full Name',
          value: user.name,
        ),
        InfoTile(
          icon: Icons.mail_outline_rounded,
          label: 'Email Address',
          value: user.email,
        ),
        InfoTile(
          icon: Icons.phone_outlined,
          label: 'Phone Number',
          value: user.phone,
        ),
        InfoTile(
          icon: Icons.language_rounded,
          label: 'Location',
          value: user.location,
        ),
      ],
    );
  }
}
