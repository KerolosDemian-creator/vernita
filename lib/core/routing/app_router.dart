import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/home/logic/home_cubit.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/interview/ui/interview_screen.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/main_layout.dart';
import 'package:vernita/features/onboarding/ui/onboarding_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.interviewSession:
        return MaterialPageRoute(builder: (_) => const InterviewScreen());

      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => BottomNavCubit()),
              BlocProvider(create: (_) => getIt<HomeCubit>()),
            ],
            child: const MainLayout(),
          ),
        );

      // ❌ اتشال: case Routes.errorDialog

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
