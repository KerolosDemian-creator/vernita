import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import 'package:vernita/core/widgets/app_card.dart';
import '../../../widgets/avatar_circle.dart';
import '../../data/models/user_model.dart';

/// Avatar + name + optional email, inside a card.
class ProfileAvatarHeader extends StatelessWidget {
  const ProfileAvatarHeader({
    super.key,
    required this.user,
    this.showEmail = true,
    this.showCamera = false,
  });

  final UserModel user;
  final bool showEmail;
  final bool showCamera;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        children: [
          AvatarCircle(
            size: 84,
            showCamera: showCamera,
            image: user.hasAvatar ? NetworkImage(user.avatarUrl!) : null,
          ),
          SizedBox(height: 12.h),
          Text(user.fullName, style: AppTextStyles.font16BrownPoppins600W),
          if (showEmail) ...[
            SizedBox(height: 2.h),
            Text(user.email, style: AppTextStyles.font12GreyPoppins400W),
          ],
        ],
      ),
    );
  }
}
