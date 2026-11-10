import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/calendar/logic/calendar_cubit.dart';
import 'package:vernita/features/profile/profile/logic/profile_cubit.dart';

class VernitaApp extends StatelessWidget {
  const VernitaApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      ensureScreenSize: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vernita',
          theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
          // App-wide cubits: available in every screen, including pushed routes.
          builder: (context, child) => MultiBlocProvider(
            providers: [
              // No load() here: ProfileScreen loads it after login (we need the token).
              BlocProvider(create: (_) => getIt<ProfileCubit>()),
              BlocProvider(create: (_) => getIt<CalendarCubit>()),
            ],
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFFF3E6), Color(0xFFFCE3D2)],
                ),
              ),
              child: child,
            ),
          ),
          initialRoute: Routes.main,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
