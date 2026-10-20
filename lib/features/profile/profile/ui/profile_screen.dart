import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../widgets/profile_scaffold.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/section_label.dart';
import '../logic/profile_cubit.dart';
import '../logic/profile_state.dart';
import 'widgets/career_target_card.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/profile_avatar_header.dart';

/// Screen 1: main Profile tab.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit()..load(),
      child: ProfileScaffold(
        title: 'Profile',
        showBack: false,
        trailing: RoundIconButton(
          icon: Icons.settings_outlined,
          onTap: () => Navigator.pushNamed(context, Routes.settings),
        ),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final user = state.user;
            if (user == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ProfileAvatarHeader(user: user),
                  const SectionLabel('Career Target'),
                  CareerTargetCard(user: user),
                  const SectionLabel('Personal Information'),
                  PersonalInfoCard(user: user),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
