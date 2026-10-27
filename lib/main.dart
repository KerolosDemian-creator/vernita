import 'package:flutter/material.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/vernita_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await getItSetup();
  await getIt<AuthSessionCubit>().restoreSession();

  runApp(VernitaApp(appRouter: AppRouter()));
}
