import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:vernita/core/routing/app_router.dart';
import 'package:vernita/core/routing/routes.dart';

class VernitaApp extends StatelessWidget {
  const VernitaApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilPlusInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Vernita',
          theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
          builder: (context, child) => Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFF3E6), Color(0xFFFCE3D2)],
              ),
            ),
            child: child,
          ),
          initialRoute: Routes.main,
          onGenerateRoute: appRouter.generateRoute,
        );
      },
    );
  }
}
