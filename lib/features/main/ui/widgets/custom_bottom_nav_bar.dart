import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';

class _NavColors {
  static const primary = Color(0xFFE8844F);
  static const primaryLight = Color(0xFFFCE3D2);
  static const barBg = Color(0xFFFFF3E6);
  static const inactive = Color(0xFF8A8A8A);
}

/// بيانات كل تاب: label + دالة بترجّع الأيقونة بلون حسب الحالة
class NavItemModel {
  final String label;
  final Widget Function(Color color) iconBuilder;

  const NavItemModel({required this.label, required this.iconBuilder});
}

class CustomBottomNavBar extends StatelessWidget {
  final VoidCallback onCenterTap;

  const CustomBottomNavBar({super.key, required this.onCenterTap});

  // دلوقتي Icons عادية، وبعدين بدّلها بصورك (شوف الأسفل)
  static final List<NavItemModel> _items = [
    NavItemModel(
      label: 'Home',
      iconBuilder: (c) => Icon(Icons.home_rounded, color: c, size: 24.r),
    ),
    NavItemModel(
      label: 'Calendar',
      iconBuilder: (c) =>
          Icon(Icons.calendar_month_rounded, color: c, size: 24.r),
    ),
    NavItemModel(
      label: 'Analytics',
      iconBuilder: (c) => Icon(Icons.bar_chart_rounded, color: c, size: 24.r),
    ),
    NavItemModel(
      label: 'Profile',
      iconBuilder: (c) =>
          Icon(Icons.person_outline_rounded, color: c, size: 24.r),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavCubit>().state;

    return SizedBox(
      height: 120.h, // 70 للبار + 16 margin + الجزء البارز من الزرار
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // البار نفسه
          Container(
            height: 85.h,
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            decoration: BoxDecoration(
              color: _NavColors.barBg,
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildItem(context, 0, currentIndex),
                _buildItem(context, 1, currentIndex),
                SizedBox(width: 72.w), // مكان الزرار اللي في النص
                _buildItem(context, 2, currentIndex),
                _buildItem(context, 3, currentIndex),
              ],
            ),
          ),

          // الزرار العائم
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onCenterTap,
              child: Container(
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4.r),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF2A07A), Color(0xFFE8844F)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: _NavColors.primary.withOpacity(0.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                // بدّلها بصورتك لما تجهز
                child: Icon(
                  Icons.video_call_rounded,
                  color: Colors.white,
                  size: 28.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index, int currentIndex) {
    return Expanded(
      child: _NavItem(
        model: _items[index],
        isSelected: index == currentIndex,
        onTap: () => context.read<BottomNavCubit>().changeTab(index),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final NavItemModel model;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.model,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? _NavColors.primary : _NavColors.inactive;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? _NavColors.primaryLight : Colors.transparent,
            ),
            child: model.iconBuilder(color),
          ),
          Text(model.label),
        ],
      ),
    );
  }
}
