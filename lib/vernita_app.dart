import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/di/dependency_injection.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/core/routing/routes.dart';
import 'package:vernita/features/authentication/logic/auth_session_cubit.dart';
import 'package:vernita/features/authentication/logic/auth_session_state.dart';

class VernitaApp extends StatelessWidget {
  const VernitaApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    final authSessionCubit = getIt<AuthSessionCubit>();

    return BlocProvider<AuthSessionCubit>.value(
      value: authSessionCubit,
      child: ScreenUtilPlusInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        ensureScreenSize: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Vernita',
            navigatorKey: appRouter.navigatorKey,
            theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
            initialRoute: authSessionCubit.state.isLoggedInUser
                ? Routes.main
                : Routes.logIn,
            onGenerateRoute: appRouter.generateRoute,
            builder: (context, child) =>
                BlocListener<AuthSessionCubit, AuthSessionState>(
                  listenWhen: (previous, current) =>
                      previous.isLoggedInUser && !current.isLoggedInUser,
                  listener: (context, state) => appRouter.goToLogin(),
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
          );
        },
      ),
    );
  }
}
