import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/logic/home_cubit.dart';
import 'package:vernita/features/home/logic/home_state.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/home/ui/widgets/home_before_upload_cv/error_dialog.dart';
import 'package:vernita/features/interview/ui/interview_screen.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/widgets/custom_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    const pages = [
      HomeScreen(),
      Scaffold(body: Center(child: Text('Calendar Screen'))),
      InterviewScreen(),
      Scaffold(body: Center(child: Text('Analytics Screen'))),
      Scaffold(body: Center(child: Text('Profile Screen'))),
    ];

    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, index) {
        return Scaffold(
          extendBody: true,
          body: IndexedStack(index: index, children: pages),
          bottomNavigationBar: CustomBottomNavBar(
            onCenterTap: () {
              final hasCv = context.read<HomeCubit>().state is HomeCvUploaded;

              if (!hasCv) {
                showDialog(
                  context: context,
                  builder: (_) => ErrorDialog(
                    onReturnHome: () =>
                        context.read<BottomNavCubit>().changeTab(0),
                  ),
                );
                return;
              }

              context.read<BottomNavCubit>().changeTab(
                CustomBottomNavBar.interviewTabIndex,
              );
            },
          ),
        );
      },
    );
  }
}
