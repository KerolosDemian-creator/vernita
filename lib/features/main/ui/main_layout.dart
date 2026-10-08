import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/widgets/custom_bottom_nav_bar.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeScreen(),
      Scaffold(body: Center(child: Text('Calender Screen !!!!!!!!'))),
      Scaffold(body: Center(child: Text('Analytics Screen !!!!!!!!'))),
      Scaffold(body: Center(child: Text('Profile Screen !!!!!!!!'))),
    ];

    return BlocProvider(
      create: (_) => BottomNavCubit(),
      child: BlocBuilder<BottomNavCubit, int>(
        builder: (context, index) {
          return Scaffold(
            extendBody: true, 
            body: IndexedStack(index: index, children: pages),
            bottomNavigationBar: CustomBottomNavBar(
              onCenterTap: () {
              
              },
            ),
          );
        },
      ),
    );
  }
}
