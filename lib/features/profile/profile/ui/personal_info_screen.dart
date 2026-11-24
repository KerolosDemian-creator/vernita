import 'package:flutter/material.dart';
import 'package:vernita/core/theme/app_colors.dart';
import '../../widgets/profile_scaffold.dart';
import '../../widgets/section_label.dart';
import '../logic/profile_field.dart';
import 'widgets/edit_field_sheet.dart';
import 'widgets/editable_info_card.dart';
import 'widgets/profile_avatar_header.dart';
import 'widgets/profile_user_builder.dart';

/// Screen 2: Profile details (opened from Settings > Personal Information).
/// Uses the same app-wide ProfileCubit as the Profile tab, so a change made
/// here shows up there immediately.
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      title: 'Profile',
      child: ProfileUserBuilder(
        builder: (context, user) => Column(
          children: [
            ProfileAvatarHeader(
              user: user,
              showEmail: false,
              showCamera: true, // TODO: pick a new photo
            ),
            SectionLabel(
              'Personal Information',
              trailing: GestureDetector(
                // The pencil edits the full name.
                onTap: () => showEditFieldSheet(
                  context,
                  field: ProfileField.fullName,
                  initial: user.fullName,
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 16,
                  color: AppColors.lightPeachText,
                ),
              ),
            ),
            EditableInfoCard(user: user),
          ],
        ),
      ),
    );
  }
}
