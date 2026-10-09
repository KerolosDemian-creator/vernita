import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/theme/app_colors.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';

/// بيانات كل تاب: label + index الصفحة + دالة بترجّع الأيقونة بلون حسب الحالة
class NavItemModel {
  final String label;
  final int tabIndex; // مكان الصفحة في IndexedStack
  final Widget Function(Color color) iconBuilder;

  const NavItemModel({
    required this.label,
    required this.tabIndex,
    required this.iconBuilder,
  });
}

class CustomBottomNavBar extends StatelessWidget {
  /// index صفحة الـ Interview في الـ IndexedStack
  static const int interviewTabIndex = 2;

  final VoidCallback onCenterTap;

  const CustomBottomNavBar({super.key, required this.onCenterTap});

  static final List<NavItemModel> _items = [
    NavItemModel(
      label: 'Home',
      tabIndex: 0,
      iconBuilder: (c) => Icon(Icons.home_rounded, color: c, size: 24.r),
    ),
    NavItemModel(
      label: 'Calendar',
      tabIndex: 1,
      iconBuilder: (c) =>
          Icon(Icons.calendar_month_rounded, color: c, size: 24.r),
    ),
    // index 2 محجوز للزرار اللي في النص (Interview)
    NavItemModel(
      label: 'Analytics',
      tabIndex: 3,
      iconBuilder: (c) => Icon(Icons.bar_chart_rounded, color: c, size: 24.r),
    ),
    NavItemModel(
      label: 'Profile',
      tabIndex: 4,
      iconBuilder: (c) =>
          Icon(Icons.person_outline_rounded, color: c, size: 24.r),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final currentIndex = context.watch<BottomNavCubit>().state;
    final isInterviewSelected = currentIndex == interviewTabIndex;

    return SizedBox(
      height: 120.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // البار نفسه
          Container(
            height: 85.h,
            margin: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
            decoration: BoxDecoration(
              color: AppColors.warmCream,
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
                _buildItem(context, _items[0], currentIndex),
                _buildItem(context, _items[1], currentIndex),
                SizedBox(width: 72.w), // مكان الزرار اللي في النص
                _buildItem(context, _items[2], currentIndex),
                _buildItem(context, _items[3], currentIndex),
              ],
            ),
          ),

          // الزرار العائم (Interview)
          Positioned(
            top: 0,
            child: GestureDetector(
              onTap: onCenterTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 64.r,
                height: 64.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isInterviewSelected
                        ? AppColors.lightPeachText
                        : Colors.white,
                    width: 4.r,
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFF2A07A), Color(0xFFE8844F)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.selectedIcon.withOpacity(.35),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
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

  Widget _buildItem(
    BuildContext context,
    NavItemModel model,
    int currentIndex,
  ) {
    return Expanded(
      child: _NavItem(
        model: model,
        isSelected: model.tabIndex == currentIndex,
        onTap: () => context.read<BottomNavCubit>().changeTab(model.tabIndex),
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
    final color = isSelected
        ? AppColors.lightPeachText
        : AppColors.nonSelectedIcon;

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
              color: isSelected
                  ? AppColors.selectedIcon.withOpacity(.1)
                  : Colors.transparent,
            ),
            child: model.iconBuilder(color),
          ),
          Text(model.label),
        ],
      ),
    );
  }
}