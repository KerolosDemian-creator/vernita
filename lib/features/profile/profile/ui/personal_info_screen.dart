import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/theme/app_colors.dart';
import '../../widgets/profile_scaffold.dart';
import '../../widgets/section_label.dart';
import '../logic/profile_cubit.dart';
import '../logic/profile_state.dart';
import 'widgets/editable_info_card.dart';
import 'widgets/profile_avatar_header.dart';

/// Screen 2: Profile details (opened from Settings > Personal Information).
class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..load(),
      child: ProfileScaffold(
        title: 'Profile',
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final user = state.user;
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                ProfileAvatarHeader(
                  user: user,
                  showEmail: false,
                  showCamera: true,
                ),
                SectionLabel(
                  'Personal Information',
                  trailing: GestureDetector(
                    onTap: () {}, // TODO: edit mode
                    child: const Icon(
                      Icons.edit_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                EditableInfoCard(user: user),
              ],
            );
          },
        ),
      ),
    );
  }
}
