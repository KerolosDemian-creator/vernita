import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/core/theme/app_text_styles.dart';
import '../../../widgets/app_card.dart';
import '../../../widgets/avatar_circle.dart';
import '../../data/models/user_model.dart';

/// Avatar + name (+ verified tick) + optional email, inside a card.
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
            image: user.avatarUrl == null ? null : NetworkImage(user.avatarUrl!),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(user.name, style: AppTextStyles.font16BrownPoppins600W),
              if (user.isVerified) ...[
                SizedBox(width: 5.w),
                Icon(Icons.verified_rounded, size: 16.r, color: AppColors.primary),
              ],
            ],
          ),
          if (showEmail) ...[
            SizedBox(height: 2.h),
            Text(user.email, style: AppTextStyles.font12GreyPoppins400W),
          ],
        ],
      ),
    );
  }
}
