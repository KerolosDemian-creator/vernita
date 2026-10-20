import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/forget_password/ui/forget_pass_screen.dart';
import 'package:vernita/features/authentication/log_in/ui/log_in_screen.dart';
import 'package:vernita/features/authentication/sign_up/ui/sign_up_screen.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/interview/ui/interview_screen.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/main_layout.dart';
import 'package:vernita/features/onboarding/ui/onboarding_screen.dart';
import 'package:vernita/features/profile/profile/ui/profile_screen.dart';
import 'package:vernita/features/profile/profile/ui/personal_info_screen.dart';
import 'package:vernita/features/profile/settings/ui/settings_screen.dart';
import 'package:vernita/features/profile/notifications/ui/notifications_screen.dart';
import 'package:vernita/features/profile/security/ui/security_screen.dart';


class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.logIn:
        return MaterialPageRoute(builder: (_) => const LogInScreen());

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case Routes.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.interviewSession:
        return MaterialPageRoute(builder: (_) => const InterviewScreen());

      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case Routes.personalInfo:
        return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());

      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());

      case Routes.security:
        return MaterialPageRoute(builder: (_) => const SecurityScreen());



      case Routes.main:
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (_) => BottomNavCubit()),
              BlocProvider(create: (_) => getIt<CvUploadCubit>()),
            ],
            child: const MainLayout(),
          ),
        );



      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
