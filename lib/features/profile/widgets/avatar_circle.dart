import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:vernita/core/theme/app_colors.dart';

/// Round profile picture with an orange ring and optional camera badge.
/// Shows a person icon until a real [image] is provided.
class AvatarCircle extends StatelessWidget {
  const AvatarCircle({
    super.key,
    this.image,
    this.size = 84,
    this.showCamera = false,
    this.onCameraTap,
  });

  final ImageProvider? image;
  final double size;
  final bool showCamera;
  final VoidCallback? onCameraTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.r,
      height: size.r,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: size.r,
            height: size.r,
            padding: EdgeInsets.all(3.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary, width: 2.5),
            ),
            child: CircleAvatar(
              backgroundColor: AppColors.badgeEnd,
              backgroundImage: image,
              child: image == null
                  ? Icon(
                      Icons.person_rounded,
                      size: (size * 0.5).r,
                      color: AppColors.brownText,
                    )
                  : null,
            ),
          ),
          if (showCamera)
            Positioned(
              right: -2.r,
              bottom: -2.r,
              child: GestureDetector(
                onTap: onCameraTap,
                child: Container(
                  width: 26.r,
                  height: 26.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.fieldFill,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.badgeShadow,
                        offset: Offset(0, 3),
                        blurRadius: 8,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.photo_camera_outlined,
                    size: 14.r,
                    color: AppColors.nonSelectedIcon,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
