import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/forget_password/logic/forget_pass_cubit.dart';
import 'package:vernita/features/authentication/forget_password/ui/forget_pass_screen.dart';
import 'package:vernita/features/authentication/log_in/logic/log_in_cubit.dart';
import 'package:vernita/features/authentication/log_in/ui/log_in_screen.dart';
import 'package:vernita/features/authentication/reset_password/logic/reset_pass_cubit.dart';
import 'package:vernita/features/authentication/reset_password/ui/reset_pass_screen.dart';
import 'package:vernita/features/authentication/sign_up/logic/sign_up_cubit.dart';
import 'package:vernita/features/authentication/sign_up/ui/sign_up_screen.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/home/logic/cv_upload_cubit.dart';
import 'package:vernita/features/interview/ui/interview_screen.dart';
import 'package:vernita/features/main/logic/bottom_nav_cubit.dart';
import 'package:vernita/features/main/ui/main_layout.dart';
import 'package:vernita/features/notifications/ui/notifications_screen.dart';
import 'package:vernita/features/onboarding/ui/onboarding_screen.dart';
import 'package:vernita/features/settings/ui/notification_settings_screen.dart';
import 'package:vernita/features/settings/ui/settings_screen.dart';

class AppRouter {
  AppRouter({GlobalKey<NavigatorState>? navigatorKey})
    : navigatorKey = navigatorKey ?? GlobalKey<NavigatorState>();

  final GlobalKey<NavigatorState> navigatorKey;

  /// Clears the navigation stack and returns to the login screen after a
  /// logout or a protected-request authentication failure.
  void goToLogin() {
    navigatorKey.currentState?.pushNamedAndRemoveUntil(
      Routes.logIn,
      (route) => false,
    );
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case Routes.logIn:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<LogInCubit>(),
            child: const LogInScreen(),
          ),
        );

      case Routes.signUp:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<SignUpCubit>(),
            child: const SignUpScreen(),
          ),
        );

      case Routes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<ForgetPassCubit>(),
            child: const ForgotPasswordScreen(),
          ),
        );

      case Routes.resetPassword:
        final email = settings.arguments is String
            ? settings.arguments as String
            : '';
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) =>
                getIt<ResetPassCubit>()..emailController.text = email,
            child: const ResetPasswordScreen(),
          ),
        );

      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case Routes.interviewSession:
        return MaterialPageRoute(builder: (_) => const InterviewScreen());
      case Routes.notification:
        return MaterialPageRoute(builder: (_) => const NotificationsScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.notificationSettings:
        return MaterialPageRoute(
          builder: (_) => const NotificationSettingsScreen(),
        );

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
