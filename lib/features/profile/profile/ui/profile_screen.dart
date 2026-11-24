import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/routing/routes.dart';
import '../../widgets/profile_scaffold.dart';
import '../../widgets/round_icon_button.dart';
import '../../widgets/section_label.dart';
import '../logic/profile_cubit.dart';
import 'widgets/career_target_card.dart';
import 'widgets/personal_info_card.dart';
import 'widgets/profile_avatar_header.dart';
import 'widgets/profile_user_builder.dart';

/// Screen 1: main Profile tab.
/// The ProfileCubit is provided app-wide (VernitaApp); this screen only asks
/// it to load the user from the backend once the tab is created.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return ProfileScaffold(
      title: 'Profile',
      showBack: false,
      trailing: RoundIconButton(
        icon: Icons.settings_outlined,
        onTap: () => Navigator.pushNamed(context, Routes.settings),
      ),
      child: ProfileUserBuilder(
        builder: (context, user) => Column(
          children: [
            ProfileAvatarHeader(user: user),
            const SectionLabel('Career Target'),
            CareerTargetCard(user: user),
            const SectionLabel('Personal Information'),
            PersonalInfoCard(user: user),
          ],
        ),
      ),
    );
  }
}
