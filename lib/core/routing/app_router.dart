import 'package:flutter/material.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/forget_password/forget_pass_screen.dart';
import 'package:vernita/features/authentication/log_in/log_in_screen.dart';
import 'package:vernita/features/authentication/sign_up/sign_up_screen.dart';
import 'package:vernita/features/home/ui/home_screen.dart';
import 'package:vernita/features/onboarding/ui/onboarding_screen.dart';

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

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
