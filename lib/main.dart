import 'package:flutter/material.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/vernita_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await getItSetup();
  runApp(VernitaApp(appRouter: AppRouter()));
}
