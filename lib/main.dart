import 'package:flutter/material.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/vernita_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItSetup();
  await checkIfLoggedInUser();

  runApp(VernitaApp(appRouter: AppRouter()));
}

/// Restores the secure session before the router chooses its initial screen.
///
/// [AuthSessionCubit] is the single in-memory source of truth, so this reads
/// the token through the same storage path used by every other auth operation.
Future<void> checkIfLoggedInUser() async {
  await getIt<AuthSessionCubit>().restoreSession();
}
